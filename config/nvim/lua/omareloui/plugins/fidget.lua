return {
  "j-hui/fidget.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = {
    notification = {
      window = {
        winblend = 0,
      },
    },
  },
}
