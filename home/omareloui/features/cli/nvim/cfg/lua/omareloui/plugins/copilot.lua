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
        dismiss = "<C-e>",
      },
    },
    panel = {
      enabled = true,
      auto_refresh = true,
      keymap = {
        jump_prev = "[c",
        jump_next = "]c",
        accept = "<C-l>",
        refresh = "gr",
        open = "<C-x>",
      },
    },
    filetypes = {
      help = false,
      oil = false,
      ["*"] = true,
    },
  },
}
