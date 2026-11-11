// tmux-style copy mode: vim keys scroll the terminal that was focused when it opened.
// Leaving (q, Esc, Enter, a click elsewhere) jumps back to the live screen.
// v opens copy mode: the history in nvim (copy.lua), in a zoomed split over the pane,
// at the part that was on screen. When nvim quits, its pane closes and the zoom ends.
// It draws nothing itself: it shares { terminal } as "scroll-mode", and the
// pane header (pane-bar) shows the badge on that terminal's pane.
import { View, div } from "gpui-kit";
import { run, props, focused, closeOverlay, setShared, appHome } from "herdr";

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

// Runs in the copy pane, as `herdr-copy` (pane-bar looks for that name in its argv):
// $1 terminal, $2 lines up, $3 pages up, $4 at top (1/0), $5 copy.lua. Reads the history,
// drops trailing blanks, works out the line that was at the top of the screen, opens nvim there.
const COPY_SCRIPT = `
f=$(mktemp -t herdr-copy) || exit 1
trap 'rm -f "$f" "$f.raw"' EXIT HUP TERM
rows=$(hc read "$1" | grep -v '^\\[hc\\] ' | wc -l)
hc read "$1" --lines 5000 | grep -v '^\\[hc\\] ' > "$f.raw"
n=$(wc -l < "$f.raw")
awk '{ sub(/[ \\t]+$/, ""); a[NR] = $0 } $0 != "" { m = NR } END { for (i = 1; i <= m; i++) print a[i] }' "$f.raw" > "$f"
line=$(awk -v n="$n" -v r="$rows" -v l="$2" -v p="$3" -v top="$4" 'BEGIN { if (top == "1") { print 1; exit } x = int(n - r + 1 - l - p * r); print (x < 1 ? 1 : x) }')
HERDR_COPY_LINE=$line nvim -R -n "$f" -c "luafile $5"
`;

export default class ScrollMode extends View {
  init(_props, cx) {
    this.terminal = focused()?.terminal ?? null;
    this.pane = focused()?.pane ?? null;
    this.stayScrolled = false;
    // How far up from the live screen we've scrolled, so copy mode opens there.
    this.up = { lines: 0, pages: 0, top: false };
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
    if (!this.terminal) return;
    run("terminal.scroll", { terminal: this.terminal, ...move });
    if (move.to) this.up = { lines: 0, pages: 0, top: move.to === "top" };
    else if (!this.up.top) {
      this.up.lines -= move.lines ?? 0;
      this.up.pages -= move.pages ?? 0;
    } else if ((move.lines ?? move.pages) > 0) {
      // Moving down from the top: we no longer know where we are; open at the live end.
      this.up = { lines: 0, pages: 0, top: false };
    }
  }

  copy() {
    // Needs a pane to split (not a layout terminal block).
    if (!this.terminal || !this.pane) return;
    const { lines, pages, top } = this.up;
    closeOverlay(props().overlay);
    // The new pane takes the keyboard, so the zoom without a pane zooms it.
    run("pane.split", { direction: "right", pane: this.pane, argv: ["sh", "-c", COPY_SCRIPT, "herdr-copy",
      this.terminal, String(Math.max(0, lines)), String(Math.max(0, pages)), top ? "1" : "0",
      `${appHome()}/mods/scroll-mode/copy.lua`] });
    run("pane.zoom", {});
  }

  key(e, cx) {
    cx.stop_propagation();
    // Plain keys by the character they type (so shift-g is "G"), chords by their name.
    const k = /^(ctrl|cmd|alt)-/.test(e.keystroke) ? e.keystroke : (e.key_char ?? e.key);
    if (k === "q" || k === "escape" || k === "enter" || k === "ctrl-c") { closeOverlay(props().overlay); return; }
    if (k === "v" || k === "V") { this.copy(); return; }
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
