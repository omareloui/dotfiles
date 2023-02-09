M = { "ellisonleao/gruvbox.nvim", lazy = false, priority = 1001 }

function M.config()
  local present, gruvbox = pcall(require, "gruvbox")

  if not present then
    return
  end

  gruvbox.setup {
    transparent_mode = true,
    contrast = "hard",
  }

  require "omareloui.config.theme"
end

return M
