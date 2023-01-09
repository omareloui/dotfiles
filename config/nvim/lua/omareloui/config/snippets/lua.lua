local ls = require "luasnip" --{{{
local i = ls.i

local f = ls.function_node

local fmt = require("luasnip.extras.fmt").fmt --}}}

local snippets_config_factory = require "omareloui.config.snippets.utils"
local cs, snippets, autosnippets = snippets_config_factory("*.lua", "LuaSnippets")
------------------------------ Start Refactoring ------------------------------
cs(
  "req",
  fmt([[local {} = require "{}"]], {
    f(function(import_name)
      local name_spaces = vim.split(import_name[1][1], ".", true)
      local last_name = name_spaces[#name_spaces] or ""
      return last_name:gsub("-", "_")
    end, { 1 }),
    i(1, "package_name"),
  })
)

cs(
  "preq",
  fmt(
    [[local present, {} = pcall(require, "{}")

if not present then
  return
end]],
    {
      f(function(import_name)
        local name_spaces = vim.split(import_name[1][1], ".", true)
        local last_name = name_spaces[#name_spaces] or ""
        return last_name:gsub("-", "_")
      end, { 1 }),
      i(1, "package_name"),
    }
  )
)

------------------------------- End Refactoring -------------------------------
return snippets, autosnippets
