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
