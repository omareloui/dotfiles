filetype plugin on

" Automating installing Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo '~/.vim/autoload/plug.vim' --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


""""""""' Plugins '""""""""
call plug#begin('~/.vim/plugged')
Plug 'psliwka/vim-smoothie' " Smooth scrolling
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-surround' " Surrondings
Plug 'scrooloose/syntastic' " Hacker view
Plug 'mkitt/tabline.vim' " Tabline
Plug 'itchyny/lightline.vim' " Lightline Themes (Themes for Tabline)
Plug 'preservim/nerdcommenter' " Commenter 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder
Plug 'junegunn/fzf.vim'
call plug#end()

"""' Plugin settings '"""
" Commenter
let g:NERDSpaceDelims = 1

" Lightline
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
let g:lightline = { 'colorscheme': 'powerline' }
""""""' End Plugins '""""""



" Cursor stuff
let &t_SI = "\e[5 q" " Cursor on insert mode
let &t_EI = "\e[2 q" " Cursor on normal mode


" Key mappings
imap jk <Esc>


" Commenting stuff
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro


" Tab with sapces
filetype plugin indent on
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2


" Line Numbers
set nu rnu
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
