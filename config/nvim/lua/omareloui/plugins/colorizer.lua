local M = { "norcalli/nvim-colorizer.lua", enabled = false }

M.config = function()
  local present, colorizer = pcall(require, "colorizer")

  if not present then
    return
  end

  local options = {
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
  }

  colorizer.setup(options)
end

return M
