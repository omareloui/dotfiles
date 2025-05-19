return {
  "codethread/qmk.nvim",
  opts = {
    name = "LAYOUT",
    comment_preview = {
      keymap_overrides = {
        SYM_LABK = "<",
        SYM_RABK = ">",
        SYM_LBRC = "[",
        SYM_RBRC = "]",
        SYM_LPRN = "(",
        SYM_RPRN = ")",
        SYM_LCBR = "{",
        SYM_RCBR = "}",
        SYM_SCLN = ";",
        SYM_COLN = ":",
        QK_LLCK = "lock",
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
