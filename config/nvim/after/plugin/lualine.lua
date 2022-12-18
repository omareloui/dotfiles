require("lualine").setup({
  sections = { lualine_c = { require('auto-session-library').current_session_name } }
})
