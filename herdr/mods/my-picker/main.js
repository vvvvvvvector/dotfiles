// Go to a tab, vim style. Opens in normal mode: j/k (or ctrl-j/ctrl-k, arrows)
// move, gg/G jump to the ends, Enter or l goes, x closes the tab, q or Esc
// leaves. / filters: typing narrows the list, ctrl-j/ctrl-k still move, Enter
// goes, Esc clears it and goes back to normal mode. Every space is listed.

import { View, div, svg } from "gpui-kit";
import { v_flex, h_flex, InputState, Input, ScrollHandle } from "gpui-base";
import { agents, spaces, run, theme, props, closeOverlay, shared, setShared } from "herdr";

const MARK = { ansi6: "#22a99a", ansi3: "#e3814f", ansi4: "#5b8def", ansi5: "#8b7cf6", ansi2: "#3fae6a", ansi1: "#d9649a" };

// Space colors, kept by space id in shared "space.colors", the same way the
// shipped mods assign them, so the tiles match the sidebar.
const PROJECT_COLORS = ["ansi6", "ansi3", "ansi4", "ansi5", "ansi2", "ansi1"];
function spaceColors() {
  const ids = new Set(spaces().map((p) => p.id));
  const kept = Object.fromEntries(Object.entries(shared("space.colors") ?? {}).filter(([id]) => ids.has(id)));
  let changed = Object.keys(kept).length !== Object.keys(shared("space.colors") ?? {}).length;
  for (const p of spaces()) {
    if (kept[p.id] || p.name === "~") continue;
    const uses = (c) => Object.values(kept).filter((v) => v === c).length;
    kept[p.id] = PROJECT_COLORS.reduce((best, c) => (uses(c) < uses(best) ? c : best));
    changed = true;
  }
  if (changed) setShared("space.colors", kept);
  return kept;
}
function spaceColor(t, p) {
  if (p.name === "~") return t.dim;
  const c = spaceColors()[p.id] ?? PROJECT_COLORS[0];
  return c.startsWith("#") ? c : (MARK[c] ?? t[c]);
}

export default class MyPicker extends View {
  init(_props, cx) {
    this.mode = "normal";
    this.filter = "";
    this.at = null;
    this.pendingG = false;
    this.handle = cx.focus_handle();
    this.scroll = ScrollHandle.new();
    this.input = InputState.new({ placeholder: "filter" });
    this.input.on("change", (_e, cx) => {
      this.filter = this.input.value();
      this.at = 0;
      this.reveal();
      cx.notify();
    });
    this.input.on("submit", () => this.go(this.rows().filter((r) => r.kind === "tab")[this.at]));
    // Escape is the app's (it closes the overlay before our key handler sees
    // it): a binding of our own, deeper in, comes first.
    try {
      cx.bind_keys([{ keystroke: "escape", action: "my_picker_escape", context: "MyPicker" }]);
    } catch {}
    this.handle.focus();
    cx.timer.after(50, () => { if (this.mode === "normal") this.handle.focus(); });
  }

  close() {
    closeOverlay(props().overlay);
  }

  rows() {
    const f = this.filter.toLowerCase();
    const all = agents();
    const out = [];
    for (const w of spaces()) {
      const tabs = w.tabs
        .map((tab) => ({ w, tab, mine: all.filter((a) => a.tab === tab.id) }))
        .filter((r) => !f || [w.name, r.tab.name, ...r.mine.map((a) => a.program?.name ?? "")].join(" ").toLowerCase().includes(f));
      if (!tabs.length) continue;
      out.push({ kind: "head", w });
      for (const r of tabs) out.push({ kind: "tab", ...r });
    }
    return out;
  }

  go(r) {
    if (!r) return;
    this.close();
    run("tab.select", { id: r.tab.id });
  }

  kill(r) {
    if (!r) return;
    // The last tab closes its space, and Herdr asks first: get out of the way.
    if (r.w.tabs.length === 1) this.close();
    run("tab.close", { id: r.tab.id });
  }

  move(by, count) {
    if (!count) return;
    this.at = Math.max(0, Math.min(count - 1, this.at + by));
    this.reveal();
  }

  // Keep the selected row in view; for a space's first tab, its title too.
  reveal() {
    const rows = this.rows();
    const tabs = rows.filter((r) => r.kind === "tab");
    const i = rows.indexOf(tabs[this.at]);
    if (i >= 0) this.scroll.scroll_to_item(rows[i - 1]?.kind === "head" ? i - 1 : i);
  }

  startFilter(cx) {
    this.mode = "filter";
    this.input.focus();
    // The input only exists from the next frame; focus it again once it does.
    cx.timer.after(30, () => { if (this.mode === "filter") this.input.focus(); });
    cx.notify();
  }

  escape(cx) {
    if (this.mode !== "filter") return this.close();
    // Like cancelling a vim search: the filter goes, the selection stays on its tab.
    const id = this.rows().filter((r) => r.kind === "tab")[this.at]?.tab.id;
    this.input.set_value("");
    this.filter = "";
    this.at = Math.max(0, this.rows().filter((r) => r.kind === "tab").findIndex((r) => r.tab.id === id));
    this.reveal();
    this.mode = "normal";
    this.handle.focus();
    cx.notify();
  }

  key(e, cx, count, sel) {
    const k = e.key;
    const ctrl = e.modifiers.control;
    if (ctrl && (k === "j" || k === "n")) this.move(1, count);
    else if (ctrl && (k === "k" || k === "p")) this.move(-1, count);
    else if (k === "down") this.move(1, count);
    else if (k === "up") this.move(-1, count);
    else if (this.mode === "filter") return;
    else if (k === "q") return this.close();
    else if (k === "j") this.move(1, count);
    else if (k === "k") this.move(-1, count);
    else if (k === "enter" || k === "l") return this.go(sel);
    else if (k === "x") this.kill(sel);
    else if (k === "/") this.startFilter(cx);
    else if (e.key_char === "G") { this.at = Math.max(0, count - 1); this.reveal(); }
    else if (k === "g") {
      if (this.pendingG) { this.at = 0; this.reveal(); }
      this.pendingG = !this.pendingG;
      cx.stop_propagation();
      return cx.notify();
    } else return;
    this.pendingG = false;
    cx.stop_propagation();
    cx.notify();
  }

  glyph(t, st) {
    if (st === "working") return svg("mods/workspace-chrome/spinner.svg").size(11).flex_none().text_color(t.working).spin(900);
    return div().w(11).flex_none().text_size(10).text_color(t[st] ?? t.dim).child(st === "idle" ? "○" : st ? "●" : "·");
  }

  render() {
    const t = theme();
    const rows = this.rows();
    const tabs = rows.filter((r) => r.kind === "tab");
    // Opens on where you are.
    if (this.at === null) {
      this.at = Math.max(0, tabs.findIndex((r) => r.w.active && r.tab.active));
      this.reveal();
    }
    this.at = Math.max(0, Math.min(this.at, tabs.length - 1));
    const sel = tabs[this.at];

    const row = (r) => {
      if (r.kind === "head") {
        return h_flex()
          .px(14)
          .pt(10)
          .pb(4)
          .gap(8)
          .items_center()
          .text_size(11.5)
          .font_medium()
          .text_color(r.w.active ? t.muted : t.dim)
          .child(h_flex().size(16).flex_none().rounded(4).bg(spaceColor(t, r.w)).items_center().justify_center().text_size(9.5).font_bold().text_color("#ffffff").child([...r.w.name][0]?.toUpperCase() ?? "?"))
          .child(div().truncate().child(r.w.name));
      }
      const on = r === sel;
      const here = r.w.active && r.tab.active;
      const who = r.mine.map((a) => a.program?.name ?? "agent").join(" · ");
      return h_flex()
        .id(`mp-${r.tab.id}`)
        .mx(6)
        .h(30)
        .pr(12)
        .rounded(6)
        .gap(10)
        .items_center()
        .cursor_pointer()
        .when(on, (el) => el.bg(t.hover))
        .hover((s) => s.bg(t.hover))
        .on_click(() => this.go(r))
        .child(div().w(2).h(14).flex_none().rounded(1).when(on, (d) => d.bg(t.accent)))
        .child(this.glyph(t, r.tab.status))
        .child(div().truncate().text_color(on || here ? t.foreground : t.muted).child(r.tab.name))
        .when(here, (el) => el.child(div().size(5).flex_none().rounded_full().bg(t.accent)))
        .child(div().flex_1())
        .when(r.tab.status === "blocked", (el) => el.child(div().flex_none().text_size(11).text_color(t.blocked).child("needs you")))
        .when(r.tab.status === "done", (el) => el.child(div().flex_none().text_size(11).text_color(t.done).child("finished")))
        .child(div().flex_none().text_size(11).text_color(t.dim).child(who));
    };

    const filtering = this.mode === "filter";
    return v_flex()
      .id("my-picker")
      .key_context("MyPicker")
      .on_action("my_picker_escape", (_e, cx) => this.escape(cx))
      .track_focus(this.handle)
      .w_full()
      .min_h(0)
      .py(6)
      .bg(t.popover)
      .text_size(13)
      .on_key_down((e, cx) => this.key(e, cx, tabs.length, sel))
      .when(filtering || this.filter, (el) =>
        el.child(
          h_flex().h(30).flex_none().mx(6).mb(2).px(10).gap(6).items_center().rounded(6)
            .when(filtering, (d) => d.bg(t.background))
            .child(div().flex_none().text_color(filtering ? t.accent : t.dim).child("/"))
            .child(filtering
              ? Input.new(this.input).flex_1().h_full().text_size(13).text_color(t.foreground)
              : div().flex_1().truncate().text_color(t.muted).child(this.filter)),
        ))
      .child(
        v_flex()
          .id("mp-list")
          .max_h(380)
          .min_h(0)
          .pb(4)
          .overflow_y_scroll()
          .track_scroll(this.scroll)
          .children(rows.map(row))
          .when(!tabs.length, (el) => el.child(div().px(14).py(10).text_color(t.dim).child("no matches"))),
      );
  }
}
