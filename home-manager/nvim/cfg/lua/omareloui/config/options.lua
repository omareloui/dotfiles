local HOME = os.getenv "HOME"

local undodir = nil

if HOME ~= nil then
  undodir = HOME .. "/.cache/nvim/undodir"
end

local opt = vim.opt

opt.autowrite = true
opt.guifont = { "", ":h10" }
opt.swapfile = false
opt.colorcolumn = { "80", "120" }
--opt.cursorcolumn = true
opt.cursorline = true

opt.foldcolumn = "0"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.fillchars = { eob = " ", foldopen = "", foldclose = "" }

opt.hlsearch = false
opt.linebreak = true
opt.list = true
--o.conceallevel = 2
opt.listchars = { tab = "» ", lead = "·", trail = "·", eol = "↲", nbsp = "☠" }
opt.relativenumber = true
opt.scrolloff = 4
opt.sidescrolloff = 4
opt.spell = false
--opt.spelllang = { "en_us" }
--opt.spelloptions = "camel"
opt.undodir = undodir
opt.wrap = false
opt.laststatus = 3 -- global statusline
opt.showmode = false
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.softtabstop = 2
opt.tabstop = 2
opt.ignorecase = true
opt.mouse = ""
opt.smartcase = true
opt.number = true
opt.numberwidth = 2
opt.ruler = false
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.undofile = true
opt.timeoutlen = 300
opt.updatetime = 200
opt.diffopt = "vertical"
opt.cmdheight = 1
-- opt.smoothscroll = true

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append "<>[]hl"

-- considers "-" as a part of a word.
-- vim.opt.iskeyword:append "-"

-- stop continuous comments
vim.api.nvim_create_autocmd("FileType", { command = "set formatoptions-=cro" })

vim.filetype.add {
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
  },
}
