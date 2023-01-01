M = { "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lspconfig" } }

M.config = function()
  local present, null_ls = pcall(require, "null-ls")

  if not present then
    return
  end

  local b = null_ls.builtins
  local f = b.formatting
  local d = b.diagnostics
  local c = b.code_actions

  local sources = {
    -- webdev stuff
    f.deno_fmt.with {
      condition = function(utils)
        return utils.root_has_file_matches "^mod%.[jt]s$" or utils.root_has_file_matches "^deno%.json$"
      end,
    },

    f.prettier.with {
      filetypes = {
        "markdown",
        "markdown.mdx",
        "json",
        "graphql",
        "markdown",
        "css",
        "sass",
        "scss",
        "less",
        "handlebars",
        "jsonc",
        "yaml",
        "html",
        "typescriptreact",
        "typescript",
        "vue",
        "javascriptreact",
        "javascript",
      },

      condition = function(utils)
        -- TODO: add a check here to make sure that prettier is installed to package.json
        return utils.root_has_file_matches "^%.prettierrc.*$"
      end,
    },

    d.eslint_d.with {
      condition = function(utils)
        return utils.root_has_file_matches "^%.eslintrc.*$"
      end,
    },

    -- Lua
    f.stylua,

    -- Shell
    f.shfmt,
    d.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

    d.fish,

    -- Git
    c.gitsigns,

    -- Spell
    b.completion.spell,
  }

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  null_ls.setup {
    sources = sources,

    on_attach = function(client, bufnr)
      -- Format on saving
      if client.supports_method "textDocument/formatting" then
        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format {
              bufnr = bufnr,
              filter = function(_client)
                return _client.name == "null-ls"
              end,
            }
          end,
        })
      end
    end,
  }
end

return M
