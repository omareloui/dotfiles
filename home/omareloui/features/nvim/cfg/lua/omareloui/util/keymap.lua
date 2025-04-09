local M = {}

---@param lhs string
---@param rhs string|function
---@param opts table|nil
function M.set(lhs, rhs, desc, opts)
  local final_opts = opts or {}
  final_opts.desc = desc

  local mode = final_opts.mode or "n"
  final_opts.mode = nil

  return vim.keymap.set(mode, lhs, rhs, final_opts)
end

return M
