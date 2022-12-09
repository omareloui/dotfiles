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

-- Get folding working with vscode neovim plugin
if vim.g.vscode then
  nnoremap("zM", ":call VSCodeNotify('editor.foldAll')<CR>")
  nnoremap("zR", ":call VSCodeNotify('editor.unfoldAll')<CR>")
  nnoremap("zc", ":call VSCodeNotify('editor.fold')<CR>")
  nnoremap("zC", ":call VSCodeNotify('editor.foldRecursively')<CR>")
  nnoremap("zo", ":call VSCodeNotify('editor.unfold')<CR>")
  nnoremap("zO", ":call VSCodeNotify('editor.unfoldRecursively')<CR>")
  nnoremap("za", ":call VSCodeNotify('editor.toggleFold')<CR>")

  vim.cmd [[
    function! MoveCursor(direction) abort
      if(reg_recording() == '' && reg_executing() == '')
          return 'g'.a:direction
      else
          return a:direction
      endif
    endfunction
  
    nmap <expr> j MoveCursor('j')
    nmap <expr> k MoveCursor('k')
  ]]
end
