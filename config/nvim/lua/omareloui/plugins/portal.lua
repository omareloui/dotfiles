local M = {
  "cbochs/portal.nvim",
}

M.config = function()
  local present, portal = pcall(require, "portal")

  if not present then
    return
  end

  require("omareloui.config.mappings").portal()
end

return M
