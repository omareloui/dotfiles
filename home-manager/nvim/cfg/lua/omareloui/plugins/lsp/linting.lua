return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },

  keys = {
    -- stylua: ignore
    { "<leader>ll", function() require("lint").try_lint() end, desc = "Trigger linting for current file." },
    -- {
    --   "<leader>lf",
    --   "mF:%!eslint_d --stdin --fix-to-stdout<CR>`F",
    --   desc = "Fix eslint linting errors",
    --   -- TODO: make this work (hint: auto command)
    --   -- filetype = { "javascript", "typescript" },
    -- },
    -- {
    --   "<leader>lf",
    --   "mF:%!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>`F",
    --   desc = "Fix eslint linting errors",
    --   -- TODO: make this work (hint: auto command)
    --   -- filetype = { "vue" },
    -- },
    -- {
    --   "<leader>lf",
    --   "mF:%!eslint_d --stdin --fix-to-stdout<CR>`F",
    --   desc = "Fix eslint linting errors",
    --   -- TODO: make this work (hint: auto command)
    --   -- filetype = { "javascript", "typescript", "vue" },
    --   mode = { "v" },
    -- },
  },

  config = function()
    local present, lint = pcall(require, "lint")

    -- stylua: ignore
    if not present then return end

    local pattern = "([^:]+):(%d+):(%d+):(.+)"
    local groups = { "file", "lnum", "col", "message" }

    local buf_parser = require("lint.parser").from_pattern(
      pattern,
      groups,
      nil,
      { ["source"] = "buf", ["severity"] = vim.diagnostic.severity.WARN }
    )

    lint.linters.buf = {
      cmd = "buf",
      args = {
        "lint",
        "--path",
      },
      stdin = false,
      append_fname = true,
      ignore_exitcode = true,
      parser = buf_parser,
    }

    lint.linters_by_ft = {
      astro = { "eslint_d", "cspell" },
      bzl = { "buildifier", "cspell" },
      dockerfile = { "hadolint", "cspell" },
      gitcommit = { "gitlint", "cspell" },
      go = { "golangcilint", "cspell" },
      html = { "htmlhint", "cspell" },
      javascript = { "eslint_d", "cspell" },
      javascriptreact = { "eslint_d", "cspell" },
      lua = { "luacheck", "cspell" },
      markdown = { "markdownlint", "cspell" },
      proto = { "buf", "cspell" },
      sh = { "shellcheck", "cspell" },
      sql = { "sqlfluff", "cspell" },
      svelte = { "eslint_d", "cspell" },
      text = { "cspell" },
      typescript = { "eslint_d", "cspell" },
      typescriptreact = { "eslint_d", "cspell" },
      vue = { "eslint_d", "cspell" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    local ns = require("lint").get_namespace "cspell"
    vim.diagnostic.config({ virtual_text = false }, ns)

    local set = require("omareloui.util.keymap").set
    set("<leader>ll", lint.try_lint, "Trigger linting for current file.")
  end,
}
