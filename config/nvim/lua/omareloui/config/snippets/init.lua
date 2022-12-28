local u = require "omareloui.snippets.utils"

local lua = require "omareloui.snippets.lua"
local typescript = require "omareloui.snippets.typescript"

u.ls.add_snippets(nil, {
  lua = lua,
  typescript = typescript,
})
