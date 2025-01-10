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

    -- wk.show { keys = "<C-w>", loop = true }

    -- wk.setup()
  end,
}
