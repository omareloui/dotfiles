return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  opts = {},
  config = function()
    local mark = require "harpoon.mark"
    local ui = require "harpoon.ui"

    local set = require("omareloui.util.keymap").set

    -- stylua: ignore start
    set("<leader>ho", ui.toggle_quick_menu, "Open harpoon menu")
    set("<leader>ha", mark.add_file, "Add to Harpoon")
    set("<A-1>", function() ui.nav_file(1) end, "Go to harpoon file 1")
    set("<A-2>", function() ui.nav_file(2) end, "Go to harpoon file 2")
    set("<A-3>", function() ui.nav_file(3) end, "Go to harpoon file 3")
    set("<A-4>", function() ui.nav_file(4) end, "Go to harpoon file 4")
    set("<A-h>", function() ui.nav_prev() end, "Go to previous harpoon file")
    set("<A-l>", function() ui.nav_next() end, "Go to next harpoon file")
    -- stylua: ignore end

    local wk = require "which-key"
    wk.register({ h = "+harpoon" }, { prefix = "<leader>" })
  end,
}
