return {
  "folke/trouble.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  cmd = { "TroubleToggle", "Trouble" },
  keys = {
    -- stylua: ignore start
    { "<leader>xx", function() require("trouble").toggle() end, desc = "Toggle trouble" },
    { "<leader>xw", function() require("trouble").toggle "workspace_diagnostics" end, desc = "Toggle workspace diagnostics (Trouble)" },
    { "<leader>xd", function() require("trouble").toggle "document_diagnostics" end, desc = "Toggle document diagnostics (Trouble)" },
    -- stylua: ignore end
    {
      "[q",
      function()
        local trouble = require "trouble"
        if trouble.is_open() then
          trouble.previous { skip_groups = true, jump = true }
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Previous trouble/quickfix item",
    },
    {
      "]q",
      function()
        local trouble = require "trouble"
        if trouble.is_open() then
          trouble.next { skip_groups = true, jump = true }
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok and err then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Next trouble/quickfix item",
    },
  },

  config = function()
    local ok, trouble = pcall(require, "trouble")

    -- stylua: ignore
    if not ok then return end

    local opts = {
      use_diagnostic_signs = true,
      -- severity = vim.diagnostic.WARN,
    }

    local wk = require "which-key"
    wk.add { { "<leader>x", group = "trouble" } }

    trouble.setup(opts)
  end,
}
