return {
  "nvimtools/hydra.nvim",

  config = function()
    local Hydra = require "hydra"

    local wk = require "which-key"
    wk.register({
      s = "+hydra split",
    }, { prefix = "<leader>s" })

    Hydra {
      -- string? only used in auto-generated hint
      name = "Split hydra",

      -- string | string[] modes where the hydra exists, same as `vim.keymap.set()` accepts
      mode = { "n" },

      -- string? key required to activate the hydra, when excluded, you can use
      -- Hydra:activate()
      body = "<leader>ss",

      heads = {
        { "+", "<Cmd>resize +10<CR>", { desc = "Increase window height" } },
        { "_", "<Cmd>resize -10<CR>", { desc = "Decrease window height" } },
        { ">", "<Cmd>vertical resize +10<CR>", { desc = "Increase window width" } },
        { "<", "<Cmd>vertical resize -10<CR>", { desc = "Decrease window width" } },
        { "=", "<C-w>=", { desc = "Make the splits equal" } },
        { "r", "<C-w>r", { desc = "Swap the two splits (either horizontal or vertical" } },
        { "k", "<C-w>K", { desc = "Move the split up" } },
        { "j", "<C-w>J", { desc = "Move the split down" } },
        { "h", "<C-w>H", { desc = "Move the split left" } },
        { "l", "<C-w>L", { desc = "Move the split right" } },
        { "o", "<C-w>o", { desc = "Close all other windows" } },
      },
    }
  end,
}
