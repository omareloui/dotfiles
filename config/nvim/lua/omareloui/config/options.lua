local g = vim.g

local options = {
  guifont = { "", ":h10" },

  -- Columns {{{
  colorcolumn = { "80", "120" },
  cursorcolumn = true,
  cursorline = true,
  -- }}}

  -- Folds {{{
  foldlevel = 99,
  foldlevelstart = -1,
  foldenable = true,
  foldcolumn = "1",
  -- }}}

  hlsearch = false,
  linebreak = true,
  list = true,
  conceallevel = 2,
  listchars = { tab = "» ", lead = "·", trail = "·", eol = "↲", nbsp = "☠" },
  relativenumber = true,
  scrolloff = 8,
  sidescrolloff = 8,

  -- Spelling {{{
  spell = true,
  spelllang = { "en_us" },
  spelloptions = "camel",
  -- }}}

  undodir = os.getenv "HOME" .. "/.cache/nvim/undodir",
  wrap = false,

  laststatus = 3, -- global statusline
  showmode = false,

  -- Indenting {{{
  expandtab = true,
  shiftwidth = 2,
  smartindent = true,
  softtabstop = 2,
  tabstop = 2,
  -- }}}

  fillchars = { eob = " ", foldopen = "", foldclose = "" },

  ignorecase = true,
  mouse = "a",
  smartcase = true,

  -- Numbers {{{
  number = true,
  numberwidth = 2,
  ruler = false,
  -- }}}

  signcolumn = "yes",
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  timeoutlen = 400,
  undofile = true,

  -- interval for writing swap file to disk, also used by gitsigns, and to highlight the cursor word
  updatetime = 40,

  -- to make the sessions work better
  sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
}

-- {{{
for k, v in pairs(options) do
  vim.opt[k] = v
end
-- }}}

-- Append and remove options {{{
-- disable nvim intro
vim.opt.shortmess:append "sI"

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append "<>[]hl"

-- considers "-" as a part of a word.
vim.opt.iskeyword:append "-"

-- stop continuous comments
vim.api.nvim_create_autocmd("FileType", { command = "set formatoptions-=cro" })
-- }}}

-- Neovide {{{
if g.neovide then
  -- g.neovide_refresh_rate = 65
  g.neovide_transparency = 0.7
  g.neovide_remember_dimensions = false
  g.neovide_remember_window_size = false

  -- g.neovide_cursor_animation_length = 0.13
  -- g.neovide_cursor_trail_size = 0.1

  -- g.neovide_cursor_vfx_mode = "pixiedust"
  -- g.neovide_cursor_vfx_particle_density = 20
  -- g.neovide_cursor_vfx_particle_lifetime = 2
end
-- }}}
