return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      enable_autocmd = false,
      languages = {
        angular = "<!-- %s -->",
      },
    },
  },
  {
    "echasnovski/mini.comment",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      options = {
        ignore_blank_line = true,
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
}
