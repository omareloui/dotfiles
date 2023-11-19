return {
  "stevearc/conform.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  config = function()
    local present, conform = pcall(require, "conform")

    if not present then
      return
    end

    local opts = {
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },

      formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        svelte = { "prettierd" },
        vue = { "prettierd" },
        asrto = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        graphql = { "prettierd" },
        lua = { "stylua" },
        sh = { "shfmt" },
      },
    }

    require("omareloui.config.mappings").conform(conform, opts.format_on_save)

    conform.setup(opts)
  end,
}
