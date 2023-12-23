return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["sqlls"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}
