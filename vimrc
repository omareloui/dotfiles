" Cursor stuff
let &t_SI = "\e[5 q" " Cursor on insert mode
let &t_EI = "\e[1 q" " Cursor on normal mode


" Key mappings
:imap jk <Esc>


" Commenting stuff 
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro " Remove comment on new line


" Tab with sapces
filetype plugin indent on
set expandtab " On pressing tab, insert 2 spaces
set tabstop=2 " show existing tab with 2 spaces width
set softtabstop=2 " show existing tab with 2 spaces width
set shiftwidth=2 " when indenting with '>', use 2 spaces widthimap 
