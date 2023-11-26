return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",

  -- stylua: ignore
  keys = {
    { "<leader>ho", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Open Harpoon menu" },
    { "<leader>ha", function() require("harpoon.mark").add_file() end, desc = "Add to Harpoon" },
    { "<A-1>", function() require("harpoon.ui").nav_file(1) end, desc = "Go to Harpoon file 1" },
    { "<A-2>", function() require("harpoon.ui").nav_file(2) end, desc = "Go to Harpoon file 2" },
    { "<A-3>", function() require("harpoon.ui").nav_file(3) end, desc = "Go to Harpoon file 3" },
    { "<A-4>", function() require("harpoon.ui").nav_file(4) end, desc = "Go to Harpoon file 4" },
    { "<A-h>", function() require("harpoon.ui").nav_prev() end, desc = "Go to previous Harpoon file" },
    { "<A-l>", function() require("harpoon.ui").nav_next() end, desc = "Go to next Harpoon file" },
  },

  opts = {},
}
