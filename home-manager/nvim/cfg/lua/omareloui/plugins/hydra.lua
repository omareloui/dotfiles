return {
  "nvimtools/hydra.nvim",

  enabled = false,

  config = function()
    local ok, hydra = pcall(require, "hydra")

    -- stylua: ignore
    if not ok then return end

    hydra.setup {}

    hydra {
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

    local window_navigate_hydra = {
      { "j", "<C-w>j", { desc = "Go to the down window" } },
      { "k", "<C-w>k", { desc = "Go to the up window" } },
      { "l", "<C-w>l", { desc = "Go to the left window" } },
      { "h", "<C-w>h", { desc = "Go to the right window" } },
    }

    if require "omareloui.util.has_plugin" "zellij-nav.nvim" then
      local zellij_nav = require "zellij-nav"
      window_navigate_hydra = {
        { "h", zellij_nav.left_tab, { desc = "Go to the left window or zellij tab" } },
        { "j", zellij_nav.down, { desc = "Go to the down window" } },
        { "k", zellij_nav.up, { desc = "Go to the up window" } },
        { "l", zellij_nav.right_tab, { desc = "Go to the right window or zellij tab" } },
      }
    end

    hydra {
      name = "Window navigate and move hydra",
      mode = { "n" },
      body = "<leader>w",

      heads = require("omareloui.util.tables").merge({
        { "w", "<C-w>w", { desc = "Switch windows" } },
        { "x", "<C-w>x", { desc = "Swap window with next" } },

        { "+", "<C-w>+", { desc = "Increase window height" } },
        { "-", "<C-w>-", { desc = "Decrease window height" } },
        { ">", "<C-w>>", { desc = "Increase window width" } },
        { "<", "<C-w><", { desc = "Decrease window width" } },
        { "=", "<C-w>=", { desc = "Equally high and wide" } },
        { "_", "<C-w>_", { desc = "Max out the height" } },
        { "|", "<C-w>|", { desc = "Max out the width" } },

        { "r", "<C-w>r", { desc = "Rotate windows downwards/rightwards" } },
        { "R", "<C-w>R", { desc = "Rotate windows upwards/leftwards" } },
        { "x", "<C-w>x", { desc = "Exchange current window with next one" } },

        { "K", "<C-w>K", { desc = "Move the current window to be at the very top" } },
        { "J", "<C-w>J", { desc = "Move the current window to be at the very bottom" } },
        { "H", "<C-w>H", { desc = "Move the current window to be at the very right" } },
        { "L", "<C-w>L", { desc = "Move the current window to be at the very left" } },

        {
          "d",
          "<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>",
          { desc = "Open definition in vertical split window", exit = true },
        },

        { "q", "<C-w>q", { desc = "Quite a window", exit = true } },
        { "o", "<C-w>o", { desc = "Close all other windows", exit = true } },
      }, window_navigate_hydra),
    }

    local wk_ok, wk = pcall(require, "which-key")

    if wk_ok then
      wk.add {
        { "<leader>w", group = "Hydra window move" },
        { "<leader>dd", group = "Hydra debug" },
      }
    end
  end,
}
