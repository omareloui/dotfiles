return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["jinja_lsp"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "jinja", "jinja.html" },
    }
  end,
}
