return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["clangd"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}
