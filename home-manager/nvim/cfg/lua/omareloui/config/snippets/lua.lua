local ls = require "luasnip" --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep --}}}

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
  "pcall",
  fmt(
    [[local ok, {} = pcall(require, "{}")

-- stylua: ignore
if not ok then return end]],
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
