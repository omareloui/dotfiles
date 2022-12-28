M = { "kyazdani42/nvim-web-devicons" }


M.config = function()
  local present, devicons = pcall(require, "nvim-web-devicons")

  if not present then
    return
  end

  -- TODO:
  -- require("base46").load_highlight "devicons"

  local options = {}

  devicons.setup(options)
end

return M
