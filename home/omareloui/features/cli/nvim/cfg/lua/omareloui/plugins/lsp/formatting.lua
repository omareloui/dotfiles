local dotfiles = os.getenv "DOTFILES_CONFIG" or os.getenv "HOME" .. "/.dotfiles/config"
local nvim_config = dotfiles .. "/nvim"

local format_opts = {
  lsp_fallback = true,
  async = false,
  timeout_ms = 2000,
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

        prettier = {
          options = {
            ft_parsers = {
              svg = "html",
            },
          },
        },
      },

      format_on_save = format_opts,

      formatters_by_ft = {
        angular = { "prettierd" },
        astro = { "prettierd" },
        bzl = { "buildifier" },
        cs = { "csharpier" },
        css = { "prettierd" },
        graphql = { "prettierd" },
        html = { "prettierd" },
        htmlangular = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        lua = { "stylua" },
        markdown = { "prettierd" },
        nix = { "alejandra" },
        proto = { "buf" },
        python = { "isort", "black" },
        sh = { "shfmt" },
        sql = { "sqlfluff" },
        svelte = { "prettierd" },
        svg = { "prettier" },
        templ = { "templ" },
        toml = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        vue = { "prettierd" },
        yaml = { "prettierd" },
      },

      notify_on_error = true,
    }

    local wk = require "which-key"
    wk.add { { "<leader>m", group = "make" }, { "<leader>n", group = "no" } }

    conform.setup(opts)
  end,
}
