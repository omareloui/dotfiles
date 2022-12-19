local M = {}

-- disable --
M.disabled = {
  n = {
    -- remvoe update nvchad map
    ["<leader>uu"] = "",

    -- remove the old toggle map for nvimtree
    ["<C-c>"] = { "", "" },
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

-- my mappings --
M.initial = {
  i = {
    ["jk"] = { "<ESC>", "exit insert mode" },
  },

  n = {
    -- more accessable keys
    -- [";"] = { ":", "enter command mode" },
  },

  v = {
    -- keep visual selection on intending
    ["<"] = { "<gv", "indent line backwards" },
    [">"] = { ">gv", "indent line forwards" },

    -- keep the cursor on the same position
    -- ["J"] = { "mzJ`z", "merge with next line" }
  },
}

M.clipboard = {

  n = {
    ["Y"] = { "y$", "yank to the end of the line" },

    -- system clipboard
    ["<leader>y"] = { '"+y', "yank to the system clipboard" },
    -- nnoremap("<leader>y", '"+y', { desc = "Yank to system clipboard" })
    -- nnoremap("<leader>Y", '"+Y', { desc = "Yank to system clipboard" })
    -- vnoremap("<leader>p", '"+p', { desc = "Paste from system clipboard" })
    -- nnoremap("<leader>p", '"+p', { desc = "Paste from system clipboard" })
  },

  v = {
    -- [",p"] = { "\"0p", "paste last yanked" }
  },

  -- -- Copy, and paste to/from the system clipboard
  -- vnoremap("<leader>y", '"+y', { desc = "Yank to system clipboard" })
  --
  -- nnoremap("<leader>p", '"+p', { desc = "Paste from system clipboard" })
}

M.navigation_in_file = {
  n = {
    -- Center the screen on moving half pages.
    ["<C-d>"] = { "<C-d>zz", "move down half a page" },
    ["<C-u>"] = { "<C-u>zz", "move up half a page" },

    -- Keep the cursor in the middle on search
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

return M

-- -- Duplicate lines
-- nnoremap("<A-j>", "yyp", { desc = "Duplicate line down" })
-- nnoremap("<A-k>", "yyP", { desc = "Duplicate line up" })
--
-- -- Copy, and paste to/from the system clipboard
-- nnoremap("<leader>y", '"+y', { desc = "Yank to system clipboard" })
-- vnoremap("<leader>y", '"+y', { desc = "Yank to system clipboard" })
-- nnoremap("<leader>Y", '"+Y', { desc = "Yank to system clipboard" })
--
-- nnoremap("<leader>p", '"+p', { desc = "Paste from system clipboard" })
-- vnoremap("<leader>p", '"+p', { desc = "Paste from system clipboard" })
-- nnoremap("<leader>p", '"+p', { desc = "Paste from system clipboard" })
--
-- -- Delete to void
-- nnoremap("<leader>d", '"_d', { desc = "Delete to void" })
-- vnoremap("<leader>d", '"_d', { desc = "Delete to void" })
-- nnoremap("<leader>D", '"_D', { desc = "Delete to void" })
--
-- -- Replace the word you're on
-- nnoremap("<leader>s", "<Cmd>%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace current word" })
--
-- -- Make the current file executable
-- nnoremap("<leader>x", "<Cmd>!chmod +x %<CR>", { silent = true, desc = "Make curerent file executable" })
--
-- -- Open the terminal
-- nnoremap("<leader>t", "<Cmd>split | resize 18 | term<CR>", { desc = "Open terminal" })
--
-- -- Move between tabs
-- nnoremap("<Tab>", "gt")
-- nnoremap("<S-Tab>", "gT")
--
-- -- TODO: check if "window, ui toggles, git, debug, buffer editors" in vscode's which key options if there's something I could use.
--
-- -- Split Screens
-- nnoremap("<leader>v", "<Cmd>vsplit<CR>", { desc = "Split window vertically" })
-- nnoremap("<leader>h", "<Cmd>split<CR>", { desc = "Split window horizontally" })
--
-- -- Navigation through windows (was <C-[direction]>)
-- nnoremap("<C-j>", "<C-w>j", { silent = true })
-- xnoremap("<C-j>", "<C-w>j", { silent = true })
-- nnoremap("<C-k>", "<C-w>k", { silent = true })
-- xnoremap("<C-k>", "<C-w>k", { silent = true })
-- nnoremap("<C-h>", "<C-w>h", { silent = true })
-- xnoremap("<C-h>", "<C-w>h", { silent = true })
-- nnoremap("<C-l>", "<C-w>l", { silent = true })
-- xnoremap("<C-l>", "<C-w>l", { silent = true })
--
--
-- ----------------------------------
-- --[[ ------- Plugins ------- ]] --
-- ----------------------------------
--
-- -- Open file tree
-- nnoremap("<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "Open file explorer" })
--
-- -- UndoTree
-- nnoremap("<leader>u", function() return vim.cmd("UndotreeToggle") end, { desc = "Open Undotree" })
--
-- -- Telescope
-- nnoremap("<leader>f",
--   "<Cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>",
--   { desc = "Open Telescope" })

-- local inoremap = require("omareloui.functions.keymap").inoremap
-- local nnoremap = require("omareloui.functions.keymap").nnoremap
-- local vnoremap = require("omareloui.functions.keymap").vnoremap
-- local xnoremap = require("omareloui.functions.keymap").xnoremap
-- local cnoremap = require("omareloui.functions.keymap").cnoremap

-- inoremap("jk", "<Esc>")
-- cnoremap("jk", "<Esc>")

-- -- Center the screen on moving half pages.
-- nnoremap("<C-d>", "<C-d>zz")
-- nnoremap("<C-u>", "<C-u>zz")

-- -- Keep the cursor in the middle on search
-- nnoremap("n", "nzzzv")
-- nnoremap("N", "Nzzzv")

-- -- Move text
-- vnoremap("J", "<Cmd>m '>+1<CR>gv=gv", { desc = "Move down a line" })
-- vnoremap("K", "<Cmd>m '<-2<CR>gv=gv", { desc = "Move down a line" })
-- inoremap("<C-j>", "<Cmd>m .+1<CR>==", { desc = "Move down a line" })
-- inoremap("<C-k>", "<Cmd>m .-2<cr>==", { desc = "Move down a line" })
-- nnoremap("<leader>j", "<Cmd>m .+1 <CR>==", { desc = "Move down a line" })
-- nnoremap("<leader>k", "<Cmd>m .-2 <CR>==", { desc = "Move down a line" })

-- -- Save the file if there where changes
-- -- nnoremap("<leader>w", "<Cmd>up<CR>")
-- -- nnoremap("<leader>q", "<Cmd>q<CR>")

-- -- Duplicate lines
-- nnoremap("<A-j>", "yyp", { desc = "Duplicate line down" })
-- nnoremap("<A-k>", "yyP", { desc = "Duplicate line up" })

-- -- Copy, and paste to/from the system clipboard
-- nnoremap("<leader>y", '"+y', { desc = "Yank to system clipboard" })
-- vnoremap("<leader>y", '"+y', { desc = "Yank to system clipboard" })
-- nnoremap("<leader>Y", '"+Y', { desc = "Yank to system clipboard" })

-- nnoremap("<leader>p", '"+p', { desc = "Paste from system clipboard" })
-- vnoremap("<leader>p", '"+p', { desc = "Paste from system clipboard" })
-- nnoremap("<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- -- Delete to void
-- nnoremap("<leader>d", '"_d', { desc = "Delete to void" })
-- vnoremap("<leader>d", '"_d', { desc = "Delete to void" })
-- nnoremap("<leader>D", '"_D', { desc = "Delete to void" })

-- -- Replace the word you're on
-- nnoremap("<leader>s", "<Cmd>%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace current word" })

-- -- Make the current file executable
-- nnoremap("<leader>x", "<Cmd>!chmod +x %<CR>", { silent = true, desc = "Make curerent file executable" })

-- -- Open the terminal
-- nnoremap("<leader>t", "<Cmd>split | resize 18 | term<CR>", { desc = "Open terminal" })

-- -- Move between tabs
-- nnoremap("<Tab>", "gt")
-- nnoremap("<S-Tab>", "gT")

-- -- TODO: check if "window, ui toggles, git, debug, buffer editors" in vscode's which key options if there's something I could use.

-- -- Split Screens
-- nnoremap("<leader>v", "<Cmd>vsplit<CR>", { desc = "Split window vertically" })
-- nnoremap("<leader>h", "<Cmd>split<CR>", { desc = "Split window horizontally" })

-- -- Navigation through windows (was <C-[direction]>)
-- nnoremap("<C-j>", "<C-w>j", { silent = true })
-- xnoremap("<C-j>", "<C-w>j", { silent = true })
-- nnoremap("<C-k>", "<C-w>k", { silent = true })
-- xnoremap("<C-k>", "<C-w>k", { silent = true })
-- nnoremap("<C-h>", "<C-w>h", { silent = true })
-- xnoremap("<C-h>", "<C-w>h", { silent = true })
-- nnoremap("<C-l>", "<C-w>l", { silent = true })
-- xnoremap("<C-l>", "<C-w>l", { silent = true })

-- ----------------------------------
-- --[[ ------- Plugins ------- ]] --
-- ----------------------------------

-- -- Open file tree
-- nnoremap("<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "Open file explorer" })

-- -- Telescope
-- nnoremap("<leader>f",
--   "<Cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>",
--   { desc = "Open Telescope" })
