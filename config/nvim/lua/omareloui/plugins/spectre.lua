return {
  "nvim-pack/nvim-spectre",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  build = false,
  cmd = "Spectre",
  opts = { open_cmd = "noswapfile vnew" },
  keys = require("omareloui.config.mappings").spectre(),
}
