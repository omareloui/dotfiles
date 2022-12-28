local u = require "omareloui.config.snippets.utils"

local lua = require "omareloui.config.snippets.lua"
local typescript = require "omareloui.config.snippets.typescript"

u.ls.add_snippets(nil, {
  lua = lua,
  typescript = typescript,
})
