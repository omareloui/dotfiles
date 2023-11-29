return {
  "sindrets/diffview.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  keys = {
    { "<leader>go", "<Cmd>DiffviewOpen<CR>", desc = "Open diff view" },
    { "<leader>gc", "<Cmd>DiffviewClose<CR>", desc = "Close diff view" },
    { "<leader>gds", "<Cmd>DiffviewFileHistory -g --range=stash<CR>", desc = "Open diff view for stash" },
    { "<leader>gfh", "<Cmd>DiffviewFileHistory %<CR>", desc = "Open file history" },
  },
  opts = {
    file_panel = {
      listing_style = "list",
      win_config = {
        position = "right",
        width = 35,
      },
    },
    keymaps = {
      file_panel = {
        { "n", "cc", "<Cmd>Git commit <bar> wincmd J<CR>", { desc = "Commit staged changes" } },
        { "n", "ca", "<Cmd>Git commit --amend <bar> wincmd J<CR>", { desc = "Amend the last commit" } },
        { "n", "p", "<Cmd>Git push<CR>", { desc = "Push to origin" } },
        { "n", "<leader>q", "<Cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
      },
    },
  },
}
