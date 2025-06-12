return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = "<C-l>",
        next = "<C-j>",
        prev = "<C-k>",
        dismiss = "<C-]>",
      },
    },
    panel = {
      enabled = false,
    },
    filetypes = {
      help = false,
      oil = false,
      ["*"] = true,
    },
  },
}
