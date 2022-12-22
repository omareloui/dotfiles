local present, ls = pcall(require, "luasnip")

if not present then
  return
end

M = {}

local ls = require "luasnip"
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

M.ls = ls
M.snip = snip
M.node = node
M.text = text
M.insert = insert
M.func = func
M.choice = choice
M.dynamicn = dynamicn

return M
