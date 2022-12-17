local inoremap = require("omareloui.functions.keymap").inoremap
local nmap     = require("omareloui.functions.keymap").nmap
local nnoremap = require("omareloui.functions.keymap").nnoremap
local vnoremap = require("omareloui.functions.keymap").vnoremap
local xnoremap = require("omareloui.functions.keymap").xnoremap
local cnoremap = require("omareloui.functions.keymap").cnoremap

-- Save the file if there where changes
nnoremap("<leader>w", ":up<CR>")
nnoremap("<leader>q", ":q<CR>")

inoremap("jk", "<Esc>")
cnoremap("jk", "<Esc>")

-- Center the screen on moving half pages.
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

-- Keep the cursor in the middle on search
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- Move text
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")
inoremap("<C-j>", ":m .+1<CR>==")
inoremap("<C-k>", ":m .-2<cr>==")
nnoremap("<leader>j", ":m .+1 <CR>==")
nnoremap("<leader>k", ":m .-2 <CR>==")

-- Copy, and paste to/from the system clipboard
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')
nnoremap("<leader>Y", '"+Y')

nnoremap("<leader>p", '"+p')
vnoremap("<leader>p", '"+p')
nnoremap("<leader>p", '"+p')

-- Delete to void
nnoremap("<leader>d", '"_d')
vnoremap("<leader>d", '"_d')
nnoremap("<leader>D", '"_D')

-- Replace the word you're on
nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Make the current file executable
nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })


-- TODO: make this function work with nvim.
-- -- Resize Windows
-- function _G.manageEditorSize(provided_count, to)
--   local count = (provided_count and (provided_count > 0)) and provided_count or 1
--   local function_to_call = (to == "increase") and "workbench.action.increaseViewSize" or
--       "workbench.action.decreaseViewSize"
--   for i = 1, count, 1 do
--     vim.fn.VSCodeNotify(function_to_call)
--   end
-- end

-- nnoremap("<C-w>=", ":call VSCodeNotify('workbench.action.evenEditorWidths')<CR>", { silent = true })
-- xnoremap("<C-w>=", ":call VSCodeNotify('workbench.action.evenEditorWidths')<CR>", { silent = true })
-- nnoremap("<C-w>>", ":lua manageEditorSize(vim.v.count, 'increase')<CR>", { silent = true })
-- xnoremap("<C-w>>", ":lua manageEditorSize(vim.v.count, 'increase')<CR>", { silent = true })
-- nnoremap("<C-w><", ":lua manageEditorSize(vim.v.count, 'decrease')<CR>", { silent = true })
-- xnoremap("<C-w><", ":lua manageEditorSize(vim.v.count, 'decrease')<CR>", { silent = true })

-- -- Navigation through windows
-- nnoremap("<C-j>", ":call VSCodeNotify('workbench.action.navigateDown')<CR>", { silent = true })
-- xnoremap("<C-j>", ":call VSCodeNotify('workbench.action.navigateDown')<CR>", { silent = true })
-- nnoremap("<C-k>", ":call VSCodeNotify('workbench.action.navigateUp')<CR>", { silent = true })
-- xnoremap("<C-k>", ":call VSCodeNotify('workbench.action.navigateUp')<CR>", { silent = true })
-- nnoremap("<C-h>", ":call VSCodeNotify('workbench.action.navigateLeft')<CR>", { silent = true })
-- xnoremap("<C-h>", ":call VSCodeNotify('workbench.action.navigateLeft')<CR>", { silent = true })
-- nnoremap("<C-l>", ":call VSCodeNotify('workbench.action.navigateRight')<CR>", { silent = true })
-- xnoremap("<C-l>", ":call VSCodeNotify('workbench.action.navigateRight')<CR>", { silent = true })


----------------------------------
--[[ ------- Plugins ------- ]] --
----------------------------------

-- Open file tree
-- nnoremap("<leader>pv", "<cmd>Ex<CR>")
nnoremap("<leader>e", "<cmd>Lex 30<CR>")

-- UndoTree
nnoremap("<leader>u", function() return vim.cmd("UndotreeToggle") end)

-- Telescope
nnoremap("<leader>f",
  "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>")
