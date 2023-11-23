return {
  "folke/which-key.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },

  config = function()
    local ok, wk = pcall(require, "which-key")

    -- stylua: ignore
    if not ok then return end

    wk.register {
      g = "+goto",
      ["]"] = "+next",
      ["["] = "+previous",
      ["<leader>b"] = "+buffer",
      ["<leader>s"] = "+split",
    }
  end,
}
