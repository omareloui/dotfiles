return {
  "folke/which-key.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local ok, wk = pcall(require, "which-key")

    -- stylua: ignore
    if not ok then return end

    wk.add {
      { "<leader>s", group = "split" },
    }

    local has_plugin = require "omareloui.util.has_plugin"

    if has_plugin "harpoon" then
      wk.add { { "<leader>h", group = "harpoon" } }
    end

    wk.setup {}
  end,
}
