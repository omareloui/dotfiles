return {
  "swaits/zellij-nav.nvim",
  lazy = true,
  event = "VeryLazy",
  keys = {
    { "<A-h>", "<Cmd>ZellijNavigateLeftTab<CR>", { silent = true, desc = "Navigate left or tab" } },
    { "<A-j>", "<Cmd>ZellijNavigateDown<CR>", { silent = true, desc = "Navigate down" } },
    { "<A-k>", "<Cmd>ZellijNavigateUp<CR>", { silent = true, desc = "Navigate up" } },
    { "<A-l>", "<Cmd>ZellijNavigateRightTab<CR>", { silent = true, desc = "Navigate right or tab" } },
  },

  config = function()
    local ok, zellij_nav = pcall(require, "zellij-nav")

    -- stylua: ignore
    if not ok then return end

    vim.api.nvim_create_autocmd("VimLeave", {
      pattern = "*",
      command = "silent !zellij action switch-mode normal",
    })

    zellij_nav.setup {}
  end,
}
