return {
  "kyazdani42/nvim-web-devicons",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = {
    override = {
      astro = {
        icon = "",
        color = "#ff5d01",
        name = "astro",
      },
    },
  },
}
