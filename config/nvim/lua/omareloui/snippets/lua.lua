local u = require "omareloui.snippets.utils"

return {
  u.snip("preq", {
    u.text { "local present, " },
    u.insert(1, "package_name"),
    u.text { ' = require "' },
    u.insert(2, "pn"),
    u.text { '"', "", "if not present then", "  return", "end", "", "" },
    u.insert(0),
  }),
}
