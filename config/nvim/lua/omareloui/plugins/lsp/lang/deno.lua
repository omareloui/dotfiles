return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["denols"].setup {
      root_dir = lspconfig.util.root_pattern("mod.js", "mod.ts", "deno.json"),
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}
