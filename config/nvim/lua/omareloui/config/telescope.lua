local actions = require "telescope.actions"

local default_mappings_file = {
  mappings = {
    n = {
      ["q"] = actions.close,
      ["<CR>"] = actions.file_tab,
    },
    i = {
      ["<CR>"] = actions.file_tab,
    },
  },
}

return {
  extensions_list = { "themes", "terms", "file_browser" },
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
  },
  defaults = {
    -- initial_mode = "normal",
  },
  pickers = {
    find_files = default_mappings_file,
    live_grep = default_mappings_file,
    buffers = default_mappings_file,
    oldfiles = default_mappings_file,
  },
}
