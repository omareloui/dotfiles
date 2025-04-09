return {
  "norcalli/nvim-colorizer.lua",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = {
    ["*"] = {
      RGB = true,
      RRGGBB = true,
      names = true,
      RRGGBBAA = true,
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
      mode = "background",
    },
  },
}
