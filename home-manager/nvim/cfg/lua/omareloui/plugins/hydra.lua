return {
  "nvimtools/hydra.nvim",

  config = function()
    local Hydra = require "hydra"

    local wk = require "which-key"

    wk.add {
      { "<Ctr-w>", group = "hydra window move" },
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
        { "q", "", { exit = true } },

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
        { "q", "", { exit = true } },

        { "c", function() require("dap").continue() end, { desc = "Debug: Start/continue" } },
        { "i", function() require("dap").step_into() end, { desc = "Debug: Step Into" } },
        { "j", function() require("dap").down() end, { desc = "Debug: Down" } },
        { "k", function() require("dap").up() end, { desc = "Debug: Up" } },
      },
    }

    Hydra {
      name = "Window move hydra",
      mode = { "n" },
      body = "<C-w>",
      heads = {
        { "j", "<C-w>j", { desc = "Go to the down window" } },
        { "k", "<C-w>k", { desc = "Go to the up window" } },
        { "l", "<C-w>l", { desc = "Go to the left window" } },
        { "h", "<C-w>h", { desc = "Go to the right window" } },

        { "w", "<C-w>w", { desc = "Switch windows" } },
        { "x", "<C-w>x", { desc = "Swap window with next" } },

        { "+", "<C-w>+", { desc = "Increase window height" } },
        { "-", "<C-w>-", { desc = "Decrease window height" } },
        { ">", "<C-w>>", { desc = "Increase window width" } },
        { "<", "<C-w><", { desc = "Decrease window width" } },
        { "=", "<C-w>=", { desc = "Make the splits equal" } },
        { "_", "<C-w>_", { desc = "Max out the height" } },
        { "|", "<C-w>|", { desc = "Max out the width" } },

        -- Move windows
        { "r", "<C-w>r", { desc = "Rotate windows downwards/rightwards" } },
        { "R", "<C-w>R", { desc = "Rotate windows upwards/leftwards" } },
        { "x", "<C-w>x", { desc = "Exchange current window with next one" } },

        { "K", "<C-w>K", { desc = "Move the current window to be at the very top" } },
        { "J", "<C-w>J", { desc = "Move the current window to be at the very bottom" } },
        { "H", "<C-w>H", { desc = "Move the current window to be at the very right" } },
        { "L", "<C-w>L", { desc = "Move the current window to be at the very left" } },
      },
    }
  end,
}
