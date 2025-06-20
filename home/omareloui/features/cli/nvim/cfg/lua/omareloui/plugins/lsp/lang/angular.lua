return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["angularls"].setup {
      capabilities = capabilities,
      on_attach = function(client)
        -- HACK: disable angular renaming capability due to duplicate rename popping up
        client.server_capabilities.renameProvider = false
        on_attach(client)
      end,
    }
  end,
}
