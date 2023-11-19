return {
  "gbprod/yanky.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },

  config = function()
    local present, yanky = pcall(require, "yanky")

    if not present then
      return
    end

    local opts = {
      highlight = { timer = 60 },

      system_clipboard = {
        sync_with_ring = true,
      },
    }

    M.keys = require("omareloui.config.mappings").yanky()

    yanky.setup(opts)
  end,
}
