local M = {
  "gbprod/yanky.nvim",
  dependencies = { "kkharji/sqlite.lua" },
}

M.config = function()
  local present, yanky = pcall(require, "yanky")

  if not present then
    return
  end

  yanky.setup {
    highlight = { timer = 50 },

    system_clipboard = {
      sync_with_ring = true,
    },
  }
end

return M
