local M = {}

local hl = require "omareloui.highlights"

M.ui = {
  theme = "onedark",
  hl_override = hl.override,
  hl_add = hl.add,
  tabufline = {},
  -- transparency = true,
}

M.plugins = require "omareloui.plugins"

M.mappings = require "omareloui.mappings"

return M
