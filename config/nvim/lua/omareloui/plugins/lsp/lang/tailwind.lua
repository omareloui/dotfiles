return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["tailwindcss"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "templ", "astro", "javascript", "typescript", "react" },
      init_options = { userLanguages = { templ = "html" } },
    }
  end,
}
