return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["tsserver"].setup {
      capabilities = capabilities,
      on_attach = function()
        on_attach()
        require("omareloui.config.mappings").tsserver()
      end,
    }
  end,
}
