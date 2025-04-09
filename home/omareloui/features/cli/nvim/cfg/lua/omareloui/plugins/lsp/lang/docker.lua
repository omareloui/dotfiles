return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["dockerls"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
    lspconfig["docker_compose_language_service"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}
