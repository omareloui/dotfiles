return {
  "zbirenbaum/neodim",
  event = "LspAttach",
  enabled = false,
  opts = {
    refresh_delay = 75,
    alpha = 0.75,
    blend_color = "#000000",
    hide = {
      underline = true,
      virtual_text = true,
      signs = true,
    },
    regex = {
      "[uU]nused",
      "[nN]ever ([rR]ead|[uU]sed)",
      "[nN]ot [rR]ead",
    },
    priority = 128,
    disable = {},
  },
}
