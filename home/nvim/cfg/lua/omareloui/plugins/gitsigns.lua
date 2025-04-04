return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },

  config = function()
    local ok, gs = pcall(require, "gitsigns")

    -- stylua: ignore
    if not ok then return end

    local options = {
      signs = { changedelete = { text = "–" } },
      preview_config = { border = "rounded" },
      current_line_blame = true,
      on_attach = function(buffer)
        local function set(lhs, rhs, desc, opts)
          opts = opts or {}
          opts.buffer = buffer
          require("omareloui.util.keymap").set(lhs, rhs, desc, opts)
        end

        -- stylua: ignore start
        set("<leader>gfd", gs.diffthis, "Diff this file")
        set("<leader>ghS", gs.stage_buffer, "Stage Buffer")
        set("<leader>ghR", gs.reset_buffer, "Reset Buffer")
        set("<leader>ghu", gs.stage_hunk, "Stage Hunk", { mode = { "n", "v" } })
        set("<leader>ghp", gs.preview_hunk, "Preview Hunk")
        set("<leader>ghb", function() gs.blame_line { full = true } end, "Blame Line")
        set("<leader>ghD", function() gs.diffthis "~" end, "Diff This ~")
        set("]h", gs.next_hunk, "Next Hunk")
        set("[h", gs.prev_hunk, "Prev Hunk")
        -- stylua: ignore end

        local wk = require "which-key"
        wk.add {
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunk" },
          { "<leader>gf", group = "file" },
        }
      end,
    }

    gs.setup(options)
  end,
}
