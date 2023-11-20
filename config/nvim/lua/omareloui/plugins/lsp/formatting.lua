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

      -- TODO: add deno_fmt
      formatters_by_ft = {
        asrto = { "prettierd" },
        css = { "prettierd" },
        graphql = { "prettierd" },
        html = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        lua = { "stylua" },
        markdown = { "prettierd" },
        sh = { "shfmt" },
        svelte = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        vue = { "prettierd" },
        yaml = { "prettierd" },
      },
    }

    require("omareloui.config.mappings").conform(conform, opts.format_on_save)

    conform.setup(opts)
  end,
}
