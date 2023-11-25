local g = vim.g

local HOME = os.getenv "HOME"

local undodir = nil

if HOME ~= nil then
  undodir = HOME .. "/.cache/nvim/undodir"
end

local o = vim.opt

o.autowrite = true
o.guifont = { "", ":h10" }
o.swapfile = false
o.colorcolumn = { "80", "120" }
--o.cursorcolumn = true
o.cursorline = true

o.foldcolumn = "0"
o.foldlevel = 99
o.foldlevelstart = -1
o.foldenable = true

o.hlsearch = false
o.linebreak = true
o.list = true
--o.conceallevel = 2
o.listchars = { tab = "» ", lead = "·", trail = "·", eol = "↲", nbsp = "☠" }
o.relativenumber = true
o.scrolloff = 4
o.sidescrolloff = 4
--o.spell = true
--o.spelllang = { "en_us" }
--o.spelloptions = "camel"
o.undodir = undodir
o.wrap = false
o.laststatus = 3 -- global statusline
o.showmode = false
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.softtabstop = 2
o.tabstop = 2
o.fillchars = { eob = " ", foldopen = "", foldclose = "" }
o.ignorecase = true
o.mouse = ""
o.smartcase = true
o.number = true
o.numberwidth = 2
o.ruler = false
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.undofile = true
o.timeoutlen = 300
o.updatetime = 200
o.diffopt = "vertical"
o.cmdheight = 1

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append "<>[]hl"

-- considers "-" as a part of a word.
-- vim.opt.iskeyword:append "-"

-- stop continuous comments
vim.api.nvim_create_autocmd("FileType", { command = "set formatoptions-=cro" })
