local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

M = {}

M.diagnostics_setup = function()
  local signs = require("omareloui.ui.icons").diagnostics

  vim.diagnostic.config {
    underline = true,
    update_in_insert = false,
    virtual_text = { prefix = "●" },
    signs = true,
    severity_sort = true,
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end
end

M.lspconfig = lspconfig

M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  require("omareloui.config.mappings").lsp(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.capabilities = capabilities

return M
