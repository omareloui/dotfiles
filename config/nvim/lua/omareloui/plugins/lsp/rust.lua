local present, rust_tools = pcall(require, "rust-tools")
local on_attach = require("omareloui.plugins.lsp.config").on_attach

if not present then
  return
end

rust_tools.setup {
  server = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      require("omareloui.config.mappings").rust_tools(bufnr)
    end,
  },
}
