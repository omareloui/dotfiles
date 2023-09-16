local M = { "folke/which-key.nvim", module = "which-key", keys = { "<leader>", '"', "'", "`" } }

M.config = function()
  local present, wk = pcall(require, "which-key")

  if not present then
    return
  end

  local options = {
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "  ", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },

    popup_mappings = {
      scroll_down = "<C-d>", -- binding to scroll down inside the popup
      scroll_up = "<C-u>", -- binding to scroll up inside the popup
    },

    window = {
      border = "none", -- none/single/double/shadow
    },

    layout = {
      spacing = 6, -- spacing between columns
    },

    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },

    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      i = { "j", "k", "J", "K" },
      v = { "j", "k" },
      c = { "s", "j", "k" },
    },
  }

  wk.setup(options)
end

return M
