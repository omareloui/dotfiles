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
    },

    f.prettier.with {
      condition = function()
        return check_if_in_package_json "prettier"
      end,
    },

    d.eslint_d.with {
      condition = function()
        return check_if_in_package_json "eslint"
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
