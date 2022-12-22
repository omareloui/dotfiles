local actions = require "telescope.actions"

return {
  extensions_list = { "themes", "terms", "file_browser" },
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
  },
  defaults = {
    -- initial_mode = "normal",
    mappings = {
      n = {
        ["q"] = actions.close,
      },
    },
  },
}
