return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },

  config = function()
    local present, lint = pcall(require, "lint")

    if not present then
      return
    end

    lint.linters_by_ft = {
      javascript = { "eslint_d", "cspell" },
      typescript = { "eslint_d", "cspell" },
      vue = { "eslint_d", "cspell" },
      svelte = { "eslint_d", "cspell" },
      javascriptreact = { "eslint_d", "cspell" },
      typescriptreact = { "eslint_d", "cspell" },
      astro = { "eslint_d", "cspell" },
      gitcommit = { "gitlint", "cspell" },
      markdown = { "markdownlint", "cspell" },
      sh = { "shellcheck", "cspell" },
      lua = { "luacheck", "cspell" },
      text = { "text" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    require("omareloui.config.mappings").lint(lint)
  end,
}
