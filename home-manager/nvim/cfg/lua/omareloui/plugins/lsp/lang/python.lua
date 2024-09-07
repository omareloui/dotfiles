return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["pyright"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}
