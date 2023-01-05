M = {
  "lmburns/lf.nvim",
  dependencies = { "plenary.nvim", "toggleterm.nvim" },
  init = require("omareloui.config.mappings").lf,
}

function M.config()
  local present, lf = require "lf"

  if present then
    return
  end

  lf.setup()
end

return M
