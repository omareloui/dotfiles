local M = {}

-- disable --
M.disabled = {
  n = {
    -- remove toggle number
    ["<leader>rn"] = "",

    -- remove update nvchad map
    ["<leader>uu"] = "",

    -- remove the old toggle map for nvimtree
    ["<C-n>"] = "",

    -- remove horizontal and vertical terminal maps
    ["<leader>h"] = "",
    ["<leader>v"] = "",

    -- remove git mappings
    ["<leader>cm"] = "",
    ["<leader>gt"] = "",
    ["<leader>rh"] = "",
    ["<leader>ph"] = "",
    ["<leader>gb"] = "",
    ["<leader>td"] = "",

    -- tabufline stuff
    ["<leader>x"] = "",
    ["<Tab>"] = "",
    ["<S-Tab>"] = "",
    ["<Bslash>"] = "",

    -- telescope
    ["<leader>pt"] = "",
  },
}

-- my mappings --
M.initial = {
  i = {
    ["jk"] = { "<ESC>", "exit insert mode", opts = { nowait = true } },
  },

  n = {
    -- more accessible keys
    [";"] = { ":", "command mode", opts = { nowait = true } },
  },

  v = {
    -- keep visual selection on intending
    ["<"] = { "<gv", "indent line backwards" },
    [">"] = { ">gv", "indent line forwards" },

    -- keep the cursor on the same position
    -- ["J"] = { "mzJ`z", "merge with next line" }

    -- more accessible keys
    [";"] = { ":", "command mode", opts = { nowait = true } },
  },
}

M.tab_navigation = {
  n = {
    ["<Tab>"] = { "<Cmd>tabn<CR>", "go to next tab" },
    ["<S-Tab>"] = { "<Cmd>tabp<CR>", "go to previous tab" },

    -- moving tabs
    ["<C-S-Right>"] = {
      "<Cmd>tabm +1<CR>",
      "move the tab to the right",
      { silent = true },
    },
    ["<C-S-Left>"] = {
      "<Cmd>tabm -1<CR>",
      "move the tab to the left",
      { silent = true },
    },

    -- new tab
    ["<C-n>"] = { "<Cmd>tabnew<CR>", "create new tab" },
    -- open closed tab
    ["<C-t>"] = {
      "<Cmd>call ReopenLastTab()<CR>",
      "reopen last closed tab",
    },
  },
}

M.clipboard = {
  n = {
    ["Y"] = { "y$", "yank to the end of the line" },

    -- system clipboard
    ["<leader>y"] = { '"+y', "yank to system clipboard" },
    ["<leader>Y"] = { '"+Y', "yank to system clipboard" },
    ["<leader>p"] = { '"+p', "paste from system clipboard" },
    ["<leader>P"] = { '"+P', "paste from system clipboard" },

    -- delete to void
    ["<leader>d"] = { '"_d', "delete to void" },
    ["<leader>D"] = { '"_D', "delete to void" },
  },

  v = {
    -- paste from last yanked not deleted
    -- [",p"] = { "\"0p", "paste last yanked" }

    -- system clipboard
    ["<leader>p"] = { '"+p', "paste from system clipboard" },
    ["<leader>y"] = { '"+y', "yank to system clipboard" },

    -- delete to void
    ["<leader>d"] = { '"_d', "delete to void" },
  },
}

M.navigation_in_file = {
  n = {
    -- center the screen on moving half pages.
    ["<C-d>"] = { "<C-d>zz", "move down half a page" },
    ["<C-u>"] = { "<C-u>zz", "move up half a page" },

    -- keep the cursor in the middle on search
    ["n"] = { "nzzzv", "find next" },
    ["N"] = { "Nzzzv", "find previous" },

    -- move text
    ["<leader>j"] = { "<Cmd>m .+1 <CR>==", "move down the line" },
    ["<leader>k"] = { "<Cmd>m .-2 <CR>==", "move up the line" },
  },

  v = {
    -- move text
    ["J"] = { "<Cmd>m '>+1<CR>gv=gv", "move down the line" },
    ["K"] = { "<Cmd>m .-2 <CR>==", "move up the line" },
  },

  i = {
    -- move text
    ["<C-j>"] = { "<Cmd>m '>+1<CR>gv=gv", "move down the line" },
    ["<C-k>"] = { "<Cmd>m .-2 <CR>==", "move up the line" },
  },
}

M.buffer_manipulation = {
  n = {
    -- use up(date) instead of (w)rite to save only when file's changed
    -- ["<leader>w"] = { "<Cmd>up<CR>", "save buffer" },
  },
}

M.text_manipulation = {
  n = {
    -- replace the word you're on
    ["<leader>s"] = {
      "<Cmd>%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
      "replace current word",
    },

    -- duplicate lines
    ["<A-j>"] = { "yyp", "duplicate line down" },
    ["<A-k>"] = { "yyP", "duplicate line up" },
  },
}

M.utils = {
  n = {
    -- make the current file executable
    -- ["<leader>x"] = { "<Cmd>!chmod +x %<CR>", "make curerent file executable" },
  },
}

M.window = {
  n = {
    -- split screens
    -- ["<leader>v"] = { "<Cmd>vsplit<CR>", "split window vertically" },
    -- ["<leader>h"] = { "<Cmd>split<CR>", "split window horizontally" },
  },
}

-- plugins --

M.nvimtree = {
  n = {
    -- toggle
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
}

M.undotree = {
  n = {
    ["<leader>u"] = {
      function()
        return vim.cmd "UndotreeToggle"
      end,
      "open Undotree",
    },
  },
}

M.git = {
  n = {
    ["<leader>gg"] = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "open lazygit" },
    ["<leader>gl"] = { "<cmd> Telescope git_bcommits <CR>", "git commits" },
    ["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "git status" },

    ["<leader>gd"] = { "<cmd> Gvdiffsplit <CR>", "git diff" },
    ["<leader>gb"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "git blame line",
    },
    ["<leader>gp"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "preview hunk",
    },
    ["<leader>ghr"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "reset hunk",
    },
    ["<leader>ghd"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "toggle show git deleted",
    },
  },
}

M.files = {
  n = {
    ["<leader>ff"] = {
      "<Cmd>Telescope find_files hidden=true<CR>",
      "find files",
    },
    ["<leader>fn"] = {
      "<Cmd>Telescope file_browser files=false hide_parent_dir=true<CR>",
      "open file browser",
    },
    ["<leader>ft"] = {
      "<Cmd>Telescope file_browser hidden=true respect_gitignore=false collapse_dirs=true<CR>",
      "open folder browser",
    },
  },
}

M.todocomments = {
  n = {
    ["]t"] = {
      function()
        require("todo-comments").jump_next()
      end,
      "next todo comment",
    },
    ["[t"] = {
      function()
        require("todo-comments").jump_prev()
      end,
      "previous todo comment",
    },
  },
}

M.trouble = {
  n = {
    ["<leader>tn"] = {
      function()
        require("trouble").next { skip_groups = true, jump = true }
      end,
      "jump to next problem",
    },
    ["<leader>tp"] = {
      function()
        require("trouble").prev { skip_groups = true, jump = true }
      end,
      "jump to next problem",
    },
  },
}

M.session = {
  n = {
    ["<leader>rs"] = { "<Cmd>RestoreSession<CR>", "restore last session" },
  },
}

return M
