return {
  "nguyenvukhang/nvim-toggler",
  enabled = false,
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  keys = {
    {
      "<leader>i",
      function()
        require("nvim-toggler").toggle()
      end,
      desc = "Toggle the cursor word (eg. from true to false)",
      mode = { "n", "v" },
    },
  },
  opts = {
    remove_default_keybinds = true,
    inverses = {
      ["True"] = "False",
      ["vim"] = "emacs",
    },
  },
}
