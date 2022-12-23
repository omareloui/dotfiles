local options = {
  colorcolumn = "80,120",
  cursorline = true,
  foldexpr = "nvim_treesitter#foldexpr()",
  foldlevel = 20,
  foldmethod = "expr",
  hlsearch = false,
  linebreak = true,
  list = true,
  listchars = { tab = "» ", lead = "·", trail = "·", eol = "↲" },
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
vim.api.nvim_create_autocmd("FileType", { command = "set formatoptions-=cro" })

-- To make the sessions work better
vim.opt.sessionoptions =
  "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

if vim.g.neovide then
  require "omareloui.neovide_config"
end
