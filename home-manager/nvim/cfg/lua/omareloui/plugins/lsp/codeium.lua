return {
  "Exafunction/codeium.nvim",
  -- TODO remove this when I figure what's wrong with this
  -- enabled = os.getenv "DISTRO" ~= "nixos",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  cmd = "Codeium",
  build = ":Codeium Auth",
  opts = {},
}
