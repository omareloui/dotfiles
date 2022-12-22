local present, ls = pcall(require, "luasnip")

if not present then
  return
end

M = {}

M.ls = require "luasnip"
M.s = ls.snippet
M.n = ls.snippet_node
M.t = ls.text_node
M.i = ls.insert_node
M.f = ls.function_node
M.r = ls.restore_node
M.c = ls.choice_node
M.d = ls.dynamic_node
M.fmt = require("luasnip.extras.fmt").fmt
M.rep = require("luasnip.extras").rep

return M
