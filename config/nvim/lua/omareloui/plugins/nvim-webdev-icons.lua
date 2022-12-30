M = { "kyazdani42/nvim-web-devicons" }

M.config = function()
  local present, devicons = pcall(require, "nvim-web-devicons")

  if not present then
    return
  end

  local options = {}

  devicons.setup(options)
end

return M
