local options = {
  backup = false, -- creates a backup file
  -- clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 2, -- more space in the neovim command line for displaying messages
  colorcolumn = "80", -- color the 80th line.
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  cursorline = true, -- highlight the current line
  expandtab = true, -- convert tabs to spaces
  fileencoding = "utf-8", -- the encoding written to a file
  foldexpr = "nvim_treesitter#foldexpr()", -- fold method
  foldlevel = 20, -- fold level
  foldmethod = "expr", -- fold type
  -- formatoptions = "-cro", -- don't create comments on new lines
  guifont = "monospace:h17", -- the font used in graphical neovim applications
  hlsearch = false, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  incsearch = true,
  linebreak = true, -- companion to wrap, don't split words
  mouse = "a", -- allow the mouse to be used in neovim
  number = true, -- set numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  pumheight = 10, -- pop up menu height
  relativenumber = false, -- set relative numbered lines
  scrolloff = 8, -- is one of my fav
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  sidescrolloff = 8,
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  softtabstop = 2, -- insert 2 spaces for a tab
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  tabstop = 2, -- insert 2 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  undodir = os.getenv("HOME") .. "/.cache/nvim/undodir", -- Set a folder to keep the undo history
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  wrap = false, -- display lines as one long line, or true to wrap within screen
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.mapleader = " "

vim.cmd("set iskeyword+=-") -- Considers "-" as a part of a word.
