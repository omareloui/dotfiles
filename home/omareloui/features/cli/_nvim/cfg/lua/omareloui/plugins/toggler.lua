return {
  "nguyenvukhang/nvim-toggler",
  enabled = true,
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  keys = {
    {
      "<leader>/",
      -- stylua: ignore
      function() require("nvim-toggler").toggle() end,
      desc = "Toggle the cursor word (eg. from true to false)",
      mode = { "n", "v" },
    },
  },
  opts = {
    remove_default_keybinds = true,
    inverses = {
      ["True"] = "False",
      ["vim"] = "emacs",
      ["right"] = "left",
      ["Right"] = "Left",
    },
  },
}
