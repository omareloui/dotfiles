local nnoremap = require("omareloui.functions.keymap").nnoremap
local vnoremap = require("omareloui.functions.keymap").vnoremap
local xnoremap = require("omareloui.functions.keymap").xnoremap


-- Remove what was set nativally on vscode
nnoremap("<C-d>", "<NOP>")
nnoremap("<C-u>", "<NOP>")

-- Open whichkey
nnoremap("<Space>", ":call VSCodeNotify('whichkey.show')<CR>")
vnoremap("<Space>", ":call VSCodeNotify('whichkey.show')<CR>")

-- Resize Windows
function _G.manageEditorSize(provided_count, to)
  local count = (provided_count and (provided_count > 0)) and provided_count or 1
  local function_to_call = (to == "increase") and "workbench.action.increaseViewSize" or
      "workbench.action.decreaseViewSize"
  for i = 1, count, 1 do
    vim.fn.VSCodeNotify(function_to_call)
  end
end

nnoremap("<C-w>=", ":call VSCodeNotify('workbench.action.evenEditorWidths')<CR>", { silent = true })
xnoremap("<C-w>=", ":call VSCodeNotify('workbench.action.evenEditorWidths')<CR>", { silent = true })
nnoremap("<C-w>>", ":lua manageEditorSize(vim.v.count, 'increase')<CR>", { silent = true })
xnoremap("<C-w>>", ":lua manageEditorSize(vim.v.count, 'increase')<CR>", { silent = true })
nnoremap("<C-w><", ":lua manageEditorSize(vim.v.count, 'decrease')<CR>", { silent = true })
xnoremap("<C-w><", ":lua manageEditorSize(vim.v.count, 'decrease')<CR>", { silent = true })

-- Navigation through windows
nnoremap("<C-j>", ":call VSCodeNotify('workbench.action.navigateDown')<CR>", { silent = true })
xnoremap("<C-j>", ":call VSCodeNotify('workbench.action.navigateDown')<CR>", { silent = true })
nnoremap("<C-k>", ":call VSCodeNotify('workbench.action.navigateUp')<CR>", { silent = true })
xnoremap("<C-k>", ":call VSCodeNotify('workbench.action.navigateUp')<CR>", { silent = true })
nnoremap("<C-h>", ":call VSCodeNotify('workbench.action.navigateLeft')<CR>", { silent = true })
xnoremap("<C-h>", ":call VSCodeNotify('workbench.action.navigateLeft')<CR>", { silent = true })
nnoremap("<C-l>", ":call VSCodeNotify('workbench.action.navigateRight')<CR>", { silent = true })
xnoremap("<C-l>", ":call VSCodeNotify('workbench.action.navigateRight')<CR>", { silent = true })

-- Get folding working with vscode neovim plugin
nnoremap("zM", ":call VSCodeNotify('editor.foldAll')<CR>")
nnoremap("zc", ":call VSCodeNotify('editor.fold')<CR>")
nnoremap("zr", ":call vscodenotify('editor.unfoldall')<CR>")
nnoremap("zC", ":call VSCodeNotify('editor.foldRecursively')<CR>")
nnoremap("zo", ":call VSCodeNotify('editor.unfold')<CR>")
nnoremap("zO", ":call VSCodeNotify('editor.unfoldRecursively')<CR>")
nnoremap("za", ":call VSCodeNotify('editor.toggleFold')<CR>")


-- Show suggestions
nnoremap("K", ":call VSCodeNotify('editor.action.showHover')<CR>")

-- Change tabs
nnoremap("<Tab>", ":call VSCodeNotify('workbench.action.nextEditorInGroup')<CR>")
nnoremap("<S-Tab>", ":call VSCodeNotify('workbench.action.previousEditorInGroup')<CR>")


vnoremap("J", ":call VSCodeNotifyVisual('editor.action.moveLinesDownAction', 0)<CR><Esc>jV")
vnoremap("K", ":call VSCodeNotifyVisual('editor.action.moveLinesUpAction', 0)<CR><Esc>kV")
