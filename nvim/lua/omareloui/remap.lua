local inoremap = require("omareloui.keymap").inoremap
local nmap     = require("omareloui.keymap").nmap
local nnoremap = require("omareloui.keymap").nnoremap
local vnoremap = require("omareloui.keymap").vnoremap
local xnoremap = require("omareloui.keymap").xnoremap

nnoremap("Y", "y$")

-- Hold the indent mode
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Doens't store the new text on pasting on selected text
vnoremap("p", '"_dP')


if vim.g.vscode then
  -- Resize Windows
  function _G.manageEditorSize(provided_count, to)
    local count = (provided_count and (provided_count > 0)) and provided_count or 1
    local function_to_call = (to == 'increase') and 'workbench.action.increaseViewSize' or
        'workbench.action.decreaseViewSize'
    for i = 1, count, 1 do
      vim.fn.VSCodeNotify(function_to_call)
    end
  end

  nnoremap("<C-w>=", ":<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>", { silent = true })
  xnoremap("<C-w>=", ":<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>", { silent = true })
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


  -- Open whichkey
  nnoremap("<leader>", ":call VSCodeNotify('whichkey.show')<CR>")
  xnoremap("<leader>", ":call VSCodeNotify('whichkey.show')<CR>")

  -- Show suggestions
  nnoremap("K", ":call VSCodeNotify('editor.action.showHover')<CR>")

  -- Change tabs
  nnoremap("<Tab>", ":call VSCodeNotify('workbench.action.nextEditorInGroup')<CR>")
  nnoremap("<S-Tab>", ":call VSCodeNotify('workbench.action.previousEditorInGroup')<CR>")

  -- Move text
  vnoremap("K", ":call VSCodeNotify('editor.action.moveLinesUpAction')<CR>gv=gv")
  vnoremap("J", ":call VSCodeNotify('editor.action.moveLinesDownAction')<CR>gv=gv")
else
  inoremap("jk", "<Esc>")

  -- Open file tree
  nnoremap("<leader>pv", "<cmd>Ex<CR>")
  nnoremap("<leader>e", "<cmd>Lex 30<CR>")

  -- Move text
  vnoremap("J", ":m '>+1<CR>gv=gv")
  vnoremap("K", ":m '<-2<CR>gv=gv")
  inoremap("<C-j>", ":m .+1<CR>==")
  inoremap("<c-k>", ":m .-2<cr>==")
  nnoremap("<leader>j", ":m .+1 <CR>==")
  nnoremap("<leader>k", ":m .-2 <CR>==")

  -- Telescope
  nnoremap("<leader>f",
    "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>")
end
