local present, devicons = pcall(require, "nvim-web-devicons")

if not present then
  return
end

-- TODO:
-- require("base46").load_highlight "devicons"

-- TODO:
-- local options = { override = require("nvchad_ui.icons").devicons }
local options = {}

devicons.setup(options)
