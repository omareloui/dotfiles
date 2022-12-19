local options = {
  cmdheight = 2, -- more space in the neovim command line for displaying messages
  colorcolumn = "80", -- color the 80th line.
  cursorline = true, -- highlight the current line
  foldexpr = "nvim_treesitter#foldexpr()", -- fold method
  foldlevel = 20, -- fold level
  foldmethod = "expr", -- fold type
  guifont = "3270SemiNarrow Nerd Font Mono:h12", -- the font used in graphical neovim applications
  hlsearch = false, -- highlight all matches on previous search pattern
  linebreak = true, -- companion to wrap, don't split words
  numberwidth = 4, -- set number column width to 2 {default 4}
  relativenumber = false, -- set relative numbered lines
  scrolloff = 8, -- is one of my fav
  sidescrolloff = 8,
  undodir = os.getenv "HOME" .. "/.cache/nvim/undodir", -- Set a folder to keep the undo history
  wrap = false, -- display lines as one long line, or true to wrap within screen
}

-- set back the clipboard to neovim
vim.opt.clipboard:remove "unnamedplus"

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- considers "-" as a part of a word.
vim.opt.iskeyword:append "-"

-- To make the sessions work better
-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
