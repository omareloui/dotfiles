local M = {}

---Merges two tables into a new table
---@param t1 table First table to merge
---@param t2 table Second table to merge
---@return table result New table containing elements from both input tables
---@see table.move
function M.merge(t1, t2)
  local result = {}
  table.move(t1, 1, #t1, 1, result)
  table.move(t2, 1, #t2, #result + 1, result)
  return result
end

return M
