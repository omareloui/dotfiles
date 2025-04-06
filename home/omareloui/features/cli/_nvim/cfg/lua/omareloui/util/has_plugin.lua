return function (plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

