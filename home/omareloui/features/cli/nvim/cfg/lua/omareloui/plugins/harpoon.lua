return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",

  -- stylua: ignore
  keys = {
    { "<leader>ho", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Open Harpoon menu" },
    { "<leader>ha", function() require("harpoon.mark").add_file() end, desc = "Add to Harpoon" },
    { "<leader>hh", function() require("harpoon.ui").nav_prev() end, desc = "Go to previous Harpoon file" },
    { "<leader>hl", function() require("harpoon.ui").nav_next() end, desc = "Go to next Harpoon file" },
    { "<A-1>", function() require("harpoon.ui").nav_file(1) end, desc = "Go to Harpoon file 1" },
    { "<A-2>", function() require("harpoon.ui").nav_file(2) end, desc = "Go to Harpoon file 2" },
    { "<A-3>", function() require("harpoon.ui").nav_file(3) end, desc = "Go to Harpoon file 3" },
    { "<A-4>", function() require("harpoon.ui").nav_file(4) end, desc = "Go to Harpoon file 4" },
    { "<A-5>", function() require("harpoon.ui").nav_file(5) end, desc = "Go to Harpoon file 5" },
    { "<A-6>", function() require("harpoon.ui").nav_file(6) end, desc = "Go to Harpoon file 6" },
  },

  config = function()
    local ok, harpoon = pcall(require, "harpoon")

    -- stylua: ignore
    if not ok then return end

    harpoon.setup()

    local wk_ok, wk = pcall(require, "which-key")

    -- stylua: ignore
    if not wk_ok then return end

    wk.add { { "<leader>h", group = "harpoon" } }
  end,
}
