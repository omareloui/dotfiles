return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["omnisharp"].setup {
      cmd = {
        "dotnet",
        require("omareloui.plugins.lsp.lang.system_packages").omnisharp_dll,
      },

      capabilities = capabilities,
      on_attach = on_attach,

      settings = {
        FormattingOptions = {
          EnableEditorConfigSupport = true,
          OrganizeImports = true,
        },
        MsBuild = {
          LoadProjectsOnDemand = nil,
        },
        RoslynExtensionsOptions = {
          EnableAnalyzersSupport = true,
          EnableImportCompletion = true,
          AnalyzeOpenDocumentsOnly = nil,
        },
        Sdk = {
          IncludePrereleases = true,
        },
      },
    }
  end,
}
