local M = {
  "L3MON4D3/LuaSnip",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = { "friendly-snippets", "nvim-cmp" },
  init = require("omareloui.config.mappings").snippets,
}

function M.config()
  local present, luasnip = pcall(require, "luasnip")

  if not present then
    return
  end

  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_lua").lazy_load { paths = "~/.config/nvim/lua/omareloui/config/snippets/" }

  local types = require "luasnip.util.types"

  local options = {
    history = true,
    updateevents = "TextChanged,TextChangedI",

    enable_autosnippets = true,

    ext_opts = {
      [types.insertNode] = {
        active = {
          virt_text = { { "   﫦", "SnippetActiveInsert" } },
        },
      },
      [types.choiceNode] = {
        active = {
          virt_text = { { "   ", "SnippetActiveChoice" } },
        },
      },
    },
  }

  luasnip.config.set_config(options)

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if
        require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end

return M
