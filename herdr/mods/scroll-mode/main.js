// tmux-style copy mode: vim keys scroll the terminal that was focused when it opened.
// Leaving (q, Esc, Enter, a click elsewhere) jumps back to the live screen.
// It draws nothing itself: it shares { terminal } as "scroll-mode", and the
// pane header (my-pane) shows the badge on that terminal's pane.
import { View, div } from "gpui-kit";
import { run, props, focused, closeOverlay, setShared } from "herdr";

const MOVES = {
  j: { lines: 1 }, down: { lines: 1 }, "ctrl-e": { lines: 1 },
  k: { lines: -1 }, up: { lines: -1 }, "ctrl-y": { lines: -1 },
  "ctrl-d": { pages: 0.5 }, d: { pages: 0.5 },
  "ctrl-u": { pages: -0.5 }, u: { pages: -0.5 },
  "ctrl-f": { pages: 1 }, pagedown: { pages: 1 }, space: { pages: 1 }, " ": { pages: 1 },
  "ctrl-b": { pages: -1 }, pageup: { pages: -1 }, b: { pages: -1 },
  g: { to: "top" }, home: { to: "top" },
  G: { to: "bottom" }, end: { to: "bottom" },
};

export default class ScrollMode extends View {
  init(_props, cx) {
    this.terminal = focused()?.terminal ?? null;
    this.stayScrolled = false;
    setShared("scroll-mode", { terminal: this.terminal });
    this.handle = cx.focus_handle();
    this.handle.focus();
    cx.timer.after(100, () => this.handle.focus());
  }

  async close() {
    setShared("scroll-mode", null);
    if (this.terminal && !this.stayScrolled) run("terminal.scroll", { terminal: this.terminal, to: "bottom" });
  }

  scroll(move) {
    if (this.terminal) run("terminal.scroll", { terminal: this.terminal, ...move });
  }

  key(e, cx) {
    cx.stop_propagation();
    // Plain keys by the character they type (so shift-g is "G"), chords by their name.
    const k = /^(ctrl|cmd|alt)-/.test(e.keystroke) ? e.keystroke : (e.key_char ?? e.key);
    if (k === "q" || k === "escape" || k === "enter" || k === "ctrl-c") { closeOverlay(props().overlay); return; }
    if (k === "/" || k === "?" || k === "cmd-f") {
      this.stayScrolled = true;
      closeOverlay(props().overlay);
      if (this.terminal) run("pane.focus", { terminal: this.terminal });
      run("terminal.search", {});
      return;
    }
    const move = MOVES[k];
    if (move) this.scroll(move);
  }

  render() {
    return div().id("scroll-mode").track_focus(this.handle).on_key_down((e, cx) => this.key(e, cx)).size_full();
  }
}
