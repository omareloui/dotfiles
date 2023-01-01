local lspconfig = require("omareloui.plugins.lsp.config").lspconfig

return {
  has_in_package_json = function(package_json_dir, package_name)
    local path = lspconfig.util.path

    -- get package.json content
    local package_json_dest = path.join(package_json_dir, "package.json")
    local file = io.open(package_json_dest, "rb")
    if not file then
      return false
    end
    local json_str = file:read "*a"
    file:close()

    -- parse json
    local lunajson = require "lunajson"
    local parsed_json = lunajson.decode(json_str)

    -- check for package in dependencies and devDependencies
    if parsed_json.dependencies then
      for k, _ in pairs(parsed_json.dependencies) do
        if k == package_name then
          return true
        end
      end
    end
    if parsed_json.devDependencies then
      for k, _ in pairs(parsed_json.devDependencies) do
        if k == package_name then
          return true
        end
      end
    end

    return false
  end,
}
