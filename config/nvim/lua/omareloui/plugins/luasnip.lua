return {
  "L3MON4D3/LuaSnip",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = { "friendly-snippets", "nvim-cmp" },

  config = function()
    local present, ls = pcall(require, "luasnip")

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

    ls.config.set_config(options)

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

    local set = require("omareloui.util.keymap").set

    set("<C-j>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, "Expand the snippet or jump to the next snippet placeholder", { mode = { "i", "s" }, silent = true })
    set("<C-k>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, "Jump to the previous placeholder", { mode = { "i", "s" }, silent = true })
    set("<C-l>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, "cycle in snippet's options right", { mode = { "i", "s" }, silent = true })
    set("<C-h>", function()
      if ls.choice_active() then
        ls.change_choice(-1)
      end
    end, "cycle in snippet's options left", { mode = { "i", "s" }, silent = true })
  end,
}
