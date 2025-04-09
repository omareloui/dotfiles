return {
  enabled = false,
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["tailwindcss"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}
