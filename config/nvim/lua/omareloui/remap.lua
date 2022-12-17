local inoremap = require("omareloui.functions.keymap").inoremap
local nmap     = require("omareloui.functions.keymap").nmap
local nnoremap = require("omareloui.functions.keymap").nnoremap
local vnoremap = require("omareloui.functions.keymap").vnoremap
local xnoremap = require("omareloui.functions.keymap").xnoremap
local cnoremap = require("omareloui.functions.keymap").cnoremap

-- nnoremap(";", ":")
nnoremap("Y", "y$")

-- Hold the indent mode
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Keep the cursor on the same position
nnoremap("J", "mzJ`z")

-- Doens't store the new text on pasting on selected text
vnoremap("p", '"_dP')

-- Paste last thing that was yanked not deleted
nmap(",p", '"0p')
nmap(",P", '"0P')


-- Copy, and paste to/from the system clipboard
-- nnoremap("<leader>y", '"+y')
-- vnoremap("<leader>y", '"+y')
-- nnoremap("<leader>Y", '"+Y')

-- nnoremap("<leader>p", '"+p')
-- vnoremap("<leader>p", '"+p')
-- nnoremap("<leader>p", '"+p')

-- Delete to void
-- nnoremap("<leader>d", '"_d')
-- vnoremap("<leader>d", '"_d')
-- nnoremap("<leader>D", '"_D')

-- Replace the word you're on
-- nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Make the current file executable
-- nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Maintain the fold on moving
function _G.moveCursor(direction)
  if vim.fn.reg_recording() == "" and vim.fn.reg_executing() == "" then
    return 'g' .. direction
  else
    return direction
  end
end

nmap("j", "v:lua.moveCursor('j')", { expr = true }, vim.api.nvim_set_keymap)
nmap("k", "v:lua.moveCursor('k')", { expr = true }, vim.api.nvim_set_keymap)


if not vim.g.vscode then
  require("omareloui.nvim.remap")
else
  require("omareloui.vscode.remap")
end
