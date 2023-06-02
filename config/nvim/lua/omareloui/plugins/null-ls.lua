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

  local function check_if_in_package_json(package_name)
    local current_dir = vim.fn.expand "%:p:h"
    local package_json_dir = require("lspconfig").util.root_pattern "package.json"(current_dir)
    return require("omareloui.plugins.lsp.utils").has_in_package_json(package_json_dir, package_name)
  end

  local sources = {
    -- webdev stuff
    f.deno_fmt.with {
      condition = function(utils)
        return utils.root_has_file_matches "^mod%.[jt]s$" or utils.root_has_file_matches "^deno%.json$"
      end,
      args = function()
        return { "fmt", "-" }
      end,
    },

    f.prettierd.with {
      extra_filetypes = { "toml", "astro" },

      condition = function()
        return check_if_in_package_json "prettier"
      end,
    },

    d.eslint_d.with {
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "astro",
      },
      condition = function()
        return check_if_in_package_json "eslint"
      end,
    },

    -- b.formatting.prismaFmt,
    b.formatting.prismaFmt.with { command = "prisma", args = { "format", "--schema", "$FILENAME" } },

    -- d.stylelint,

    -- Markdown
    d.markdownlint,

    -- yaml
    d.yamllint,
    f.yamlfmt,

    -- Lua
    f.stylua,

    -- Rust
    f.rustfmt,

    -- Shell
    f.shfmt,
    d.shellcheck.with {
      condition = function()
        return not string.find(vim.fn.expand "%:t", "^%.env")
      end,
    },

    -- d.fish,

    -- Git
    -- c.gitsigns,
    d.gitlint,
    d.actionlint,

    -- Spell
    d.misspell,
    b.completion.spell,
  }

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  null_ls.setup {
    sources = sources,
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git", "Cargo.toml"),

    default_timeout = 5000,

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
