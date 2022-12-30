M = { "glepnir/lspsaga.nvim", branch = "main", init = require("omareloui.config.mappings").lspsaga }

M.config = function()
  local present, lspsaga = pcall(require, "lspsaga")

  if not present then
    return
  end

  lspsaga.init_lsp_saga {
    code_action_icon = "💡",
    code_action_lightbulb = { virtual_text = false },
    -- symbol_in_winbar = { in_custom = true },
    -- border_style = "round",
  }
end

return M
