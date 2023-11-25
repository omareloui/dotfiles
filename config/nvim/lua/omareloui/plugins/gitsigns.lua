return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },

  config = function()
    local ok, gs = pcall(require, "gitsigns")

    if not ok then
      return
    end

    local options = {
      signs = {
        add = { hl = "DiffAdd", text = "│" },
        change = { hl = "DiffChange", text = "│" },
        delete = { hl = "DiffDelete", text = "_" },
        topdelete = { hl = "DiffDelete", text = "‾" },
        changedelete = { hl = "DiffChangeDelete", text = "–" },
        untracked = { hl = "DiffAdd" },
      },
      current_line_blame = true,
      on_attach = function()
        local set = require("omareloui.util.keymap").set

        set("<leader>ghS", gs.stage_buffer, "Stage Buffer")
        set("<leader>ghR", gs.reset_buffer, "Reset Buffer")
        set("<leader>ghu", gs.stage_hunk, "Stage Hunk", { mode = { "n", "v" } })
        set("<leader>ghu", gs.reset_hunk, "Reset Hunk", { mode = { "n", "v" } })
        set("<leader>ghp", gs.preview_hunk, "Preview Hunk")
        set("<leader>ghd", gs.diffthis, "Diff This")
        set("ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk", { mode = { "o", "x" } })
        set("]h", gs.next_hunk, "Next Hunk")
        set("[h", gs.prev_hunk, "Prev Hunk")

        -- stylua: ignore start
        set("<leader>ghb", function() gs.blame_line { full = true } end, "Blame Line")
        set("<leader>ghD", function() gs.diffthis "~" end, "Diff This ~")
        -- stylua: ignore end

        local wk = require "which-key"
        wk.register({ g = "+git" }, { prefix = "<leader>" })
        wk.register({ h = "+hunk", f = "+file" }, { prefix = "<leader>g" })
      end,
    }

    require("omareloui.config.ui.highlights").gitsings()

    gs.setup(options)
  end,
}
