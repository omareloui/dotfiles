return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["volar"].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
}
