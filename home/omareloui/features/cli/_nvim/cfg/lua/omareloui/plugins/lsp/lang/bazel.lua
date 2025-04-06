return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["starlark_rust"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}
