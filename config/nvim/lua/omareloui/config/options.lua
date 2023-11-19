local g = vim.g

local HOME = os.getenv "HOME"

local undodir = nil

if HOME ~= nil then
  undodir = HOME .. "/.cache/nvim/undodir"
end

local options = {
  autowrite = true,
  guifont = { "", ":h10" },
  swapfile = false,
  colorcolumn = { "80", "120" },
  -- cursorcolumn = true,
  cursorline = true,
  foldlevel = 99,
  foldlevelstart = -1,
  foldenable = true,
  foldcolumn = "1",
  hlsearch = false,
  linebreak = true,
  list = true,
  -- conceallevel = 2,
  listchars = { tab = "» ", lead = "·", trail = "·", eol = "↲", nbsp = "☠" },
  relativenumber = true,
  scrolloff = 4,
  sidescrolloff = 4,
  -- spell = true,
  -- spelllang = { "en_us" },
  -- spelloptions = "camel",
  undodir = undodir,
  wrap = false,
  laststatus = 3, -- global statusline
  showmode = false,
  expandtab = true,
  shiftwidth = 2,
  smartindent = true,
  softtabstop = 2,
  tabstop = 2,
  fillchars = { eob = " ", foldopen = "", foldclose = "" },
  ignorecase = true,
  mouse = "",
  smartcase = true,
  number = true,
  numberwidth = 2,
  ruler = false,
  signcolumn = "yes",
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  undofile = true,
  timeoutlen = 300,
  updatetime = 200,
  diffopt = "vertical",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append "<>[]hl"

-- considers "-" as a part of a word.
-- vim.opt.iskeyword:append "-"

-- stop continuous comments
vim.api.nvim_create_autocmd("FileType", { command = "set formatoptions-=cro" })
