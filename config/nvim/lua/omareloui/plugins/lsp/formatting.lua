local nvim_config = os.getenv "DOTFILES_CONFIG" .. "/nvim"

local format_opts = {
  lsp_fallback = true,
  async = false,
  timeout_ms = 500,
}

return {
  "stevearc/conform.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  keys = {
    -- stylua: ignore
    { "<leader>mp", function() require("conform").format(format_opts) end, desc = "[M]ake [p]retty", mode = { "v", "n" } },
    { "<leader>nf", "<Cmd>noa up<CR>", desc = "Save buffer without formatting" },
  },
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

      format_on_save = format_opts,

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
        proto = { "buf" },
        sh = { "shfmt" },
        sql = { "sql_formatter" },
        svelte = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        vue = { "prettierd" },
        yaml = { "prettierd" },
      },

      notify_on_error = true,
    }

    local wk = require "which-key"
    wk.register({ m = "+make", n = "+no" }, { prefix = "<leader>" })

    conform.setup(opts)
  end,
}
