return {
  "codethread/qmk.nvim",
  opts = {
    name = "LAYOUT",
    comment_preview = {
      keymap_overrides = {
        M_LBRC = "[",
        M_LABK = "<",
        M_LCBR = "{",
        M_LPRN = "(",
      },
    },
    layout = {
      "x x x x x x _ _ _ x x x x x x",
      "x x x x x x _ _ _ x x x x x x",
      "x x x x x x _ _ _ x x x x x x",
      "x x x x x x _ _ _ x x x x x x",
      "_ _ _ _ _ x x _ x x _ _ _ _ _",
    },
    variant = "qmk",
  },
}
