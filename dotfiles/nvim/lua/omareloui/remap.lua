local inoremap = require("omareloui.keymap").inoremap
local nnoremap = require("omareloui.keymap").nnoremap
local vnoremap = require("omareloui.keymap").vnoremap

nnoremap("<leader>pv", "<cmd>Ex<CR>")
nnoremap("<leader>e", "<cmd>Lex 30<CR>")

inoremap("jk", "<Esc>")
nnoremap("Y", "y$")

-- Move text
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")
inoremap("<C-j>", ":m .+1<CR>==")
inoremap("<C-k>", ":m .-2<CR>==")
nnoremap("<leader>j", ":m .+1 <CR>==")
nnoremap("<leader>k", ":m .-2 <CR>==")

-- Hold the indent mode
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Doens't store the new text on pasting on selected text
vnoremap("p", '"_dP')

-- Telescope
nnoremap("<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>")
