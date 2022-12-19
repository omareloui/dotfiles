local M = {}

local hl = require "omareloui.highlights"

M.ui = {
  theme = "onedark",
  hl_override = hl.override,
}

M.plugins = require "omareloui.plugins"

M.mappings = require "omareloui.mappings"

return M
