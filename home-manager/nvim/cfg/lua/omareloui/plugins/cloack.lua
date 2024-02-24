return {
  "laytan/cloak.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  config = function()
    local ok, cloak = pcall(require, "cloak")

    -- stylua: ignore
    if not ok then return end

    cloak.setup {
      enabled = true,
      cloak_character = "*",
      highlight_group = "Comment",
      patterns = {
        {
          file_pattern = {
            ".env*",
            "wrangler.toml",
            ".dev.vars",
          },
          cloak_pattern = { "=.+" },
        },
      },
    }
  end,
}
