local inoremap = require("omareloui.functions.keymap").inoremap
local nnoremap = require("omareloui.functions.keymap").nnoremap
local vnoremap = require("omareloui.functions.keymap").vnoremap
local xnoremap = require("omareloui.functions.keymap").xnoremap
local cnoremap = require("omareloui.functions.keymap").cnoremap


inoremap("jk", "<Esc>")
cnoremap("jk", "<Esc>")

-- Center the screen on moving half pages.
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

-- Keep the cursor in the middle on search
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- Move text
vnoremap("J", "<Cmd>m '>+1<CR>gv=gv")
vnoremap("K", "<Cmd>m '<-2<CR>gv=gv")
inoremap("<C-j>", "<Cmd>m .+1<CR>==")
inoremap("<C-k>", "<Cmd>m .-2<cr>==")
nnoremap("<leader>j", "<Cmd>m .+1 <CR>==")
nnoremap("<leader>k", "<Cmd>m .-2 <CR>==")

-- Save the file if there where changes
nnoremap("<leader>w", "<Cmd>up<CR>")
nnoremap("<leader>q", "<Cmd>q<CR>")

-- Easier comment
nnoremap("<leader>/", "<Cmd>CommentToggle<CR>")
vnoremap("<leader>/", "<Cmd>CommentToggle<CR>")

-- Duplicate lines
nnoremap("<A-j>", "yyp")
nnoremap("<A-k>", "yyP")

-- Copy, and paste to/from the system clipboard
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')
nnoremap("<leader>Y", '"+Y')

nnoremap("<leader>p", '"+p')
vnoremap("<leader>p", '"+p')
nnoremap("<leader>p", '"+p')

-- Delete to void
nnoremap("<leader>d", '"_d')
vnoremap("<leader>d", '"_d')
nnoremap("<leader>D", '"_D')

-- Replace the word you're on
nnoremap("<leader>s", "<Cmd>%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Make the current file executable
nnoremap("<leader>x", "<Cmd>!chmod +x %<CR>", { silent = true })

-- Open the terminal
nnoremap("<leader>t", "<Cmd>split | resize 18 | term<CR>")

-- Move between tabs
nnoremap("<Tab>", "gt")
nnoremap("<S-Tab>", "gT")

-- TODO: check if "window, ui toggles, git, debug, buffer editors" in vscode's which key options if there's something I could use.

-- Split Screens
nnoremap("<leader>v", "<Cmd>vsplit<CR>")
nnoremap("<leader>h", "<Cmd>split<CR>")

-- Navigation through windows (was <C-[direction]>)
nnoremap("<C-j>", "<C-w>j", { silent = true })
xnoremap("<C-j>", "<C-w>j", { silent = true })
nnoremap("<C-k>", "<C-w>k", { silent = true })
xnoremap("<C-k>", "<C-w>k", { silent = true })
nnoremap("<C-h>", "<C-w>h", { silent = true })
xnoremap("<C-h>", "<C-w>h", { silent = true })
nnoremap("<C-l>", "<C-w>l", { silent = true })
xnoremap("<C-l>", "<C-w>l", { silent = true })


----------------------------------
--[[ ------- Plugins ------- ]] --
----------------------------------

-- Open file tree
nnoremap("<leader>e", "<Cmd>NvimTreeToggle<CR>")

-- UndoTree
nnoremap("<leader>u", function() return vim.cmd("UndotreeToggle") end)

-- Telescope
nnoremap("<leader>f",
  "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>")
