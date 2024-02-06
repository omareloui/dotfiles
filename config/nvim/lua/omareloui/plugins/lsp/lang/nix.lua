return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["nil_ls"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}
