-- Complete unimported
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format { async = false }
  end,
})

return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["templ"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig["gopls"].setup {
      filetypes = { "go", "gomod" },
      capabilities = capabilities,
      on_attach = function()
        on_attach()
        local set = require("omareloui.util.keymap").set
        set("<leader>.", "<Cmd>!go run .<CR>", 'Run "make run"')
      end,

      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
        },
      },
    }
  end,
}
