local M = {}

local function bind(op, outer_opts)
  outer_opts = outer_opts or { noremap = true }
  return function(lhs, rhs, opts, set_func)
    set_func = set_func or vim.keymap.set
    opts = vim.tbl_extend("force",
      outer_opts,
      opts or {}
    )
    set_func(op, lhs, rhs, opts)
  end
end

M.nmap = bind("n", { noremap = false })
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")
M.cnoremap = bind("c")

return M
