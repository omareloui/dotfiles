local u = require "omareloui.snippets.utils"

local ts_function_fmt = [[
{doc}
{type} {async}{name}({params}): {ret} {{
	{body}
}}
]]

local ts_function_snippet = function(type)
  return u.fmt(ts_function_fmt, {
    doc = u.func(function(args)
      local params_str = args[1][1]
      local return_type = args[2][1]
      local nodes = { "/**" }
      for _, param in ipairs(vim.split(params_str, ",", true)) do
        local name = param:match "([%a%d_-]+):?"
        local text = param:match ": ?([%S^,]+)"
        if name then
          local str = " * @param " .. name
          if text then
            str = str .. " {" .. text .. "}"
          end
          table.insert(nodes, str)
        end
      end
      vim.list_extend(nodes, { " * @returns " .. return_type, " */" })
      return nodes
    end, { 3, 4 }),
    type = u.text(type),
    async = u.choice(1, { u.text "async ", u.text "" }),
    name = u.insert(2, "funcName"),
    params = u.insert(3),
    ret = u.dynamic(4, function(args)
      local async = string.match(args[1][1], "async")
      if async == nil then
        return u.node(nil, {
          u.restore(1, "return_type", u.insert(nil, "void")),
        })
      end
      return u.node(nil, {
        u.text "Promise<",
        u.restore(1, "return_type", u.insert(nil, "void")),
        u.text ">",
      })
    end, { 1 }),
    body = u.insert(0),
  }, {
    stored = {
      ["return_type"] = u.insert(nil, "void"),
    },
  })
end

return {
  u.snip("func", ts_function_snippet "public"),
}
