M = { "glepnir/lspsaga.nvim", branch = "main", init = require("omareloui.config.mappings").lspsaga }

M.config = function()
  local present, lspsaga = pcall(require, "lspsaga")

  if not present then
    return
  end

  local options = {
    code_action_icon = "💡",
    code_action_lightbulb = { virtual_text = false },
  }

  lspsaga.init_lsp_saga(options)
end

return M
