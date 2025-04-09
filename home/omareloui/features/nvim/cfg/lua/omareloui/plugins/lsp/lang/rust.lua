return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["rust_analyzer"].setup {
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
        local set = require("omareloui.util.keymap").set

        set("K", "<Cmd>RustHoverActions<CR>", "Hover Actions (Rust)", { buffer = bufnr })
        set("<leader>ca", "<Cmd>RustCodeAction<CR>", "Code Action (Rust)", { buffer = bufnr })
      end,

      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            runBuildScripts = true,
          },
          checkOnSave = {
            allFeatures = true,
            command = "clippy",
            extraArgs = { "--no-deps" },
          },
          procMacro = {
            enable = true,
            ignored = {
              ["async-trait"] = { "async_trait" },
              ["napi-derive"] = { "napi" },
              ["async-recursion"] = { "async_recursion" },
            },
          },
        },
      },
    }
  end,
}
