return {
  "Exafunction/codeium.nvim",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    tools = {
      language_server = "/home/omareloui/.nix-profile/bin/codeium_language_server",
    },
  },
}
