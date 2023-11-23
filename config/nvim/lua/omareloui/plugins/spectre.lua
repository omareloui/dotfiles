return {
  "nvim-pack/nvim-spectre",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  build = false,
  cmd = "Spectre",
  opts = { open_cmd = "noswapfile vnew" },
  keys = {
    -- stylua: ignore
    { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
  },
}
