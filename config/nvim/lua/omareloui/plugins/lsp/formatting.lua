local nvim_config = os.getenv "DOTFILES_CONFIG" .. "/nvim"

return {
  "stevearc/conform.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  config = function()
    local present, conform = pcall(require, "conform")

    -- stylua: ignore
    if not present then return end

    local opts = {
      formatters = {
        buildifier = {
          inherit = false,
          command = "buildifier",
        },

        sql_formatter = {
          prepend_args = {
            "-c",
            nvim_config .. "/lua/omareloui/plugins/lsp/.sql_formatter.json",
          },
        },
      },

      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },

      formatters_by_ft = {
        astro = { "prettierd" },
        bzl = { "buildifier" },
        css = { "prettierd" },
        graphql = { "prettierd" },
        html = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        lua = { "stylua" },
        markdown = { "prettierd" },
        sh = { "shfmt" },
        sql = { "sql_formatter" },
        svelte = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        vue = { "prettierd" },
        yaml = { "prettierd" },
      },
    }

    local set = require("omareloui.util.keymap").set
    set("<leader>mp", function()
      conform.format(opts.format_on_save)
    end, "Make pretty", { mode = { "v", "n" } })
    set("<leader>nf", "<Cmd>noa up<CR>", "Save buffer without formatting")

    local wk = require "which-key"
    wk.register({ m = "+make", n = "+no" }, { prefix = "<leader>" })

    conform.setup(opts)
  end,
}
