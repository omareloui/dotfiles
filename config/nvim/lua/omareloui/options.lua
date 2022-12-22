local options = {
  -- cmdheight = 2,
  colorcolumn = "80,120",
  cursorline = true,
  foldexpr = "nvim_treesitter#foldexpr()",
  foldlevel = 20,
  foldmethod = "expr",
  guifont = "3270SemiNarrow Nerd Font Mono:h12",
  hlsearch = false,
  linebreak = true,
  list = true,
  listchars = { tab = "▸ ", lead = "·", trail = "·" },
  numberwidth = 4,
  relativenumber = true,
  scrolloff = 8,
  sidescrolloff = 8,
  spell = true,
  spelllang = { "en_us" },
  spelloptions = "camel",
  undodir = os.getenv "HOME" .. "/.cache/nvim/undodir",
  wrap = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- set back the clipboard to neovim
vim.opt.clipboard:remove "unnamedplus"

-- considers "-" as a part of a word.
vim.opt.iskeyword:append "-"

-- stop continuous comments
-- FIXME: doesn't work on vim start
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { command = "setlocal formatoptions-=cro" }
)

-- To make the sessions work better
vim.o.sessionoptions =
  "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
