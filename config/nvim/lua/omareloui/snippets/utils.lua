local present, ls = pcall(require, "luasnip")

if not present then
  return
end

M = {}

M.ls = require "luasnip"
M.snip = ls.snippet
M.node = ls.snippet_node
M.text = ls.text_node
M.insert = ls.insert_node
M.func = ls.function_node
M.restore = ls.restore_node
M.choice = ls.choice_node
M.dynamic = ls.dynamic_node
M.fmt = require("luasnip.extras.fmt").fmt

return M
