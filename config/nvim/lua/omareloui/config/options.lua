local g = vim.g

local options = {
  colorcolumn = "80,120",
  cursorcolumn = true,
  cursorline = true,
  foldexpr = "nvim_treesitter#foldexpr()",
  foldlevel = 20,
  foldmethod = "expr",
  guifont = { "JetBrainsMono Nerd Font", ":h10" },
  hlsearch = false,
  linebreak = true,
  list = true,
  listchars = { tab = "» ", lead = "·", trail = "·", eol = "↲", nbsp = "☠" },
  relativenumber = true,
  scrolloff = 8,
  sidescrolloff = 8,
  spell = true,
  spelllang = { "en_us" },
  spelloptions = "camel",
  undodir = os.getenv "HOME" .. "/.cache/nvim/undodir",
  wrap = false,

  laststatus = 3, -- global statusline
  showmode = false,

  -- Indenting,
  expandtab = true,
  shiftwidth = 2,
  smartindent = true,
  softtabstop = 2,
  tabstop = 2,

  fillchars = { eob = " " },
  ignorecase = true,
  mouse = "a",
  smartcase = true,

  -- Numbers,
  number = true,
  numberwidth = 2,
  ruler = false,

  signcolumn = "yes",
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  timeoutlen = 400,
  undofile = true,

  -- interval for writing swap file to disk, also used by gitsigns
  updatetime = 250,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- disable nvim intro
vim.opt.shortmess:append "sI"

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append "<>[]hl"

-- considers "-" as a part of a word.
vim.opt.iskeyword:append "-"

-- stop continuous comments
vim.api.nvim_create_autocmd("FileType", { command = "set formatoptions-=cro" })

-- to make the sessions work better
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Neovide configs
if g.neovide then
  g.neovide_refresh_rate = 65
  g.neovide_transparency = 0.60
  g.neovide_remember_dimensions = false
  g.neovide_remember_window_size = false

  g.neovide_cursor_animation_length = 0.13
  g.neovide_cursor_trail_size = 0.1

  g.neovide_cursor_vfx_mode = "pixiedust"
  g.neovide_cursor_vfx_particle_density = 20
  g.neovide_cursor_vfx_particle_lifetime = 2
end
