local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins
local f = b.formatting
local d = b.diagnostics

local sources = {
  -- webdev stuff
  f.deno_fmt,
  f.prettier,
  d.eslint_d,

  -- Lua
  f.stylua,

  -- Shell
  f.shfmt,
  d.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  d.fish,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup {
  debug = true,

  sources = sources,

  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}
