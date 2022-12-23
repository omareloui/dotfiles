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
    ["<Bslash>"] = "",

    -- telescope
    ["<leader>pt"] = "",
    ["<leader>tk"] = "",
    ["<leader>ff"] = "",

    -- lsp
    ["<leader>ra"] = "",
    ["[d"] = "",
    ["d]"] = "",
    ["<leader>wa"] = "",
    ["<leader>wr"] = "",
    ["<leader>wl"] = "",
    ["<leader>wk"] = "",
    ["<leader>wK"] = "",
    ["<leader>D"] = "",
  },
}

--------------------------------- my mappings ---------------------------------
M.initial = {
  i = {
    ["jk"] = { "<ESC>", "exit insert mode", opts = { nowait = true } },
    ["Jk"] = { "<ESC>", "exit insert mode", opts = { nowait = true } },
    ["jK"] = { "<ESC>", "exit insert mode", opts = { nowait = true } },
    ["JK"] = { "<ESC>", "exit insert mode", opts = { nowait = true } },
  },

  n = {
    -- more accessible keys
    -- [";"] = { ":", "command mode", opts = { nowait = true } },

    -- remove highlight
    ["<leader>n"] = { "<Cmd>noh<CR>", "remove search highlight" },
  },

  v = {
    -- keep visual selection on intending
    ["<"] = { "<gv", "indent line backwards" },
    [">"] = { ">gv", "indent line forwards" },

    -- keep the cursor on the same position
    -- ["J"] = { "mzJ`z", "merge with next line" }

    -- more accessible keys
    -- [";"] = { ":", "command mode", opts = { nowait = true } },
  },
}

M.buffers = {
  n = {
    -- moving buffers
    ["<C-S-Right>"] = {
      function()
        require("nvchad_ui.tabufline").move_buf(1)
      end,
      "move the tab to the right",
      { silent = true },
    },
    ["<C-S-Left>"] = {
      function()
        require("nvchad_ui.tabufline").move_buf(-1)
      end,
      "move the tab to the left",
      { silent = true },
    },

    -- use up(date) instead of (w)rite to save only when file's changed
    ["<leader>w"] = { "<Cmd>up<CR>", "save buffer" },
    ["<leader>x"] = {
      function()
        require("nvchad_ui.tabufline").closeAllBufs()
      end,
      "close all buffers",
    },
    ["<leader>q"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "close buffer",
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
    -- ["<leader>d"] = { '"_d', "delete to void" },
    -- ["<leader>D"] = { '"_D', "delete to void" },
  },

  v = {
    -- paste from last yanked not deleted
    -- [",p"] = { "\"0p", "paste last yanked" }

    -- system clipboard
    ["<leader>p"] = { '"+p', "paste from system clipboard" },
    ["<leader>y"] = { '"+y', "yank to system clipboard" },

    -- delete to void
    -- ["<leader>d"] = { '"_d', "delete to void" },
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
    -- ["<C-j>"] = { "<Cmd>m '>+1<CR>gv=gv", "move down the line" },
    -- ["<C-k>"] = { "<Cmd>m .-2 <CR>==", "move up the line" },
  },
}

M.text_manipulation = {
  n = {
    -- replace the word you're on
    ["<leader>su"] = {
      ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
      "replace current word",
    },

    -- duplicate lines
    ["<A-j>"] = { "yyp", "duplicate line down" },
    ["<A-k>"] = { "yyP", "duplicate line up" },
  },
}

M.window = {
  n = {
    -- split windows
    ["<leader>sv"] = { "<Cmd>vsplit<CR>", "split window vertically" },
    ["<leader>sh"] = { "<Cmd>split<CR>", "split window horizontally" },
    ["<leader>se"] = { "<C-w>=", "make the splits equal" },
    ["<leader>sm"] = {
      "<Cmd>MaximizerToggle<CR>",
      "toggle maximizing the current window",
    },
  },
}

----------------------------------- plugins -----------------------------------
M.lsp = {
  -- TODO: load the mappings in the lspconfig file instead of here
  n = {
    ["<leader>dp"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "go to previous diagnostic",
      { buffer = 0 },
    },
    ["<leader>dn"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "go to next diagnostic",
      { buffer = 0 },
    },
    ["<leader>dl"] = { -- after it's open you can use ctrl+q to add them to a quick fix window
      "<Cmd>Telescope diagnostics<CR>",
      "list all diagnostics",
      { buffer = 0 },
    },

    ["gt"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "lsp definition type",
      { buffer = 0 },
    },
    ["gi"] = {
      function()
        vim.lsp.buf.diagnostic()
      end,
      "got to implementation",
      { buffer = 0 },
    },
    ["<leader>lr"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
      { buffer = 0 },
    },

    -- From the core
    -- ["gD"] = {
    --   function()
    --     vim.lsp.buf.declaration()
    --   end,
    --   "lsp declaration",
    -- },
    --
    -- ["gd"] = {
    --   function()
    --     vim.lsp.buf.definition()
    --   end,
    --   "lsp definition",
    -- },
    --
    -- ["K"] = {
    --   function()
    --     vim.lsp.buf.hover()
    --   end,
    --   "lsp hover",
    -- },
    --
    -- ["gi"] = {
    --   function()
    --     vim.lsp.buf.implementation()
    --   end,
    --   "lsp implementation",
    -- },
    --
    -- ["<leader>ls"] = {
    --   function()
    --     vim.lsp.buf.signature_help()
    --   end,
    --   "lsp signature_help",
    -- },
    --
    -- ["<leader>D"] = {
    --   function()
    --     vim.lsp.buf.type_definition()
    --   end,
    --   "lsp definition type",
    -- },
    --
    -- ["<leader>ra"] = {
    --   function()
    --     require("nvchad_ui.renamer").open()
    --   end,
    --   "lsp rename",
    -- },
    --
    -- ["<leader>ca"] = {
    --   function()
    --     vim.lsp.buf.code_action()
    --   end,
    --   "lsp code_action",
    -- },
    --
    -- ["gr"] = {
    --   function()
    --     vim.lsp.buf.references()
    --   end,
    --   "lsp references",
    -- },
    --
    -- ["<leader>f"] = {
    --   function()
    --     vim.diagnostic.open_float()
    --   end,
    --   "floating diagnostic",
    -- },
    --
    --
    -- ["<leader>q"] = {
    --   function()
    --     vim.diagnostic.setloclist()
    --   end,
    --   "diagnostic setloclist",
    -- },
    --
    -- ["<leader>fm"] = {
    --   function()
    --     vim.lsp.buf.format { async = true }
    --   end,
    --   "lsp formatting",
    -- },
    --
    -- ["<leader>wa"] = {
    --   function()
    --     vim.lsp.buf.add_workspace_folder()
    --   end,
    --   "add workspace folder",
    -- },
    --
    -- ["<leader>wr"] = {
    --   function()
    --     vim.lsp.buf.remove_workspace_folder()
    --   end,
    --   "remove workspace folder",
    -- },
    --
    -- ["<leader>wl"] = {
    --   function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --   end,
    --   "list workspace folders",
    -- },
  },
}

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
    ["<leader>fa"] = {
      "<Cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
      "find all",
    },

    ["<leader>ff"] = {
      "<Cmd>Telescope find_files hidden=true<CR>",
      "find files",
    },
    ["<leader>fo"] = { "<Cmd>Telescope oldfiles<CR>", "find oldfiles" },

    ["<leader>fw"] = { "<Cmd>Telescope live_grep<CR>", "live grep" },
    ["<leader>fb"] = { "<Cmd>Telescope buffers<CR>", "find buffers" },
    ["<leader>fh"] = { "<Cmd>Telescope help_tags<CR>", "help page" },
    ["<leader>fk"] = { "<Cmd>Telescope keymaps<CR>", "show keys" },

    ["<leader>fn"] = {
      "<Cmd>Telescope file_browser files=false hide_parent_dir=true<CR>",
      "open file browser",
    },
    ["<leader>ft"] = {
      "<Cmd>Telescope file_browser hidden=true respect_gitignore=false collapse_dirs=true<CR>",
      "open folder browser",
    },
    ["<leader>fr"] = {
      "<Cmd>Telescope file_browser cwd=~/repos<CR>",
      "open all repos",
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

local expand_move_snippet_keys = {
  ["<C-k>"] = {
    function()
      local ls = require "luasnip"
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end,
    "expand the snippet or jump to the next snippet placeholder",
    { silent = true },
  },

  ["<C-j>"] = {
    function()
      local ls = require "luasnip"
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end,
    "jump to the previous placeholder",
    { silent = true },
  },

  ["<C-l>"] = {
    function()
      local ls = require "luasnip"
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end,
    "cycle in snippet's options",
    { silent = true },
  },
}

M.snippets = {
  n = {
    ["<leader><leader>s"] = {
      "<Cmd>source ~/.config/nvim/lua/omareloui/snippets/init.lua<CR>",
      "source the snippet file",
    },
  },
  i = expand_move_snippet_keys,
  s = expand_move_snippet_keys,
}

return M
