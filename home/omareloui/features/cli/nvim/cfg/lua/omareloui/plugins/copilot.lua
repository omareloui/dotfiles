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
      sh = function()
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
          return false
        end
        return true
      end,
      ["*"] = true,
    },
  },
  keys = {
    { "<leader>cx", "<Cmd>Copilot toggle<CR>", desc = "Toggle Copilot" },
  },
}
