return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["cssls"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}
