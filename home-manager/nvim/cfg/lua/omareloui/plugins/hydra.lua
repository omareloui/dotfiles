return {
  "nvimtools/hydra.nvim",

  config = function()
    local Hydra = require "hydra"

    local wk = require "which-key"

    wk.add {
      { "<leader>ss", group = "hydra split" },
      { "<leader>dd", group = "hydra debug" },
    }

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

    Hydra {
      name = "Debugger hydra",
      mode = { "n" },
      body = "<leader>dd",
      -- stylua: ignore
      heads = {
        { "c", function() require("dap").continue() end, { desc = "Debug: Start/continue" } },
        { "i", function() require("dap").step_into() end, { desc = "Debug: Step Into" } },
        { "j", function() require("dap").down() end, { desc = "Debug: Down" } },
        { "k", function() require("dap").up() end, { desc = "Debug: Up" } },
      },
    }
  end,
}
