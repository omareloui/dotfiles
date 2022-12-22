local u = require "omareloui.snippets.utils"

return {
  u.s(
    "req",
    u.fmt([[local {} = require "{}"]], {
      u.f(function(import_name)
        local modules = vim.split(import_name[1][1], ".", true)
        return modules[#modules] or ""
      end, { 1 }),
      u.i(1, "package_name"),
    })
  ),
  u.s(
    "preq",
    u.fmt(
      [[local present, {} = pcall(require, "{}")

if not present then
  return
end]],
      {
        u.f(function(import_name)
          local modules = vim.split(import_name[1][1], ".", true)
          return modules[#modules] or ""
        end, { 1 }),
        u.i(1, "package_name"),
      }
    )
  ),
}
