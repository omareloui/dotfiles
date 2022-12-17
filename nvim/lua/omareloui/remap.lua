local inoremap = require("omareloui.keymap").inoremap
local nmap     = require("omareloui.keymap").nmap
local nnoremap = require("omareloui.keymap").nnoremap
local vnoremap = require("omareloui.keymap").vnoremap
local xnoremap = require("omareloui.keymap").xnoremap
local cnoremap = require("omareloui.keymap").cnoremap

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

if vim.g.vscode then
  -- Set scrolling natively in vscode
  nnoremap("<C-d>", "<NOP>")
  nnoremap("<C-u>", "<NOP>")

  -- nnoremap("<leader>w", ":call VSCodeNotify('workbench.action.files.save')<CR>") -- Save the file if there where changes
  -- nnoremap("<leader>q", ":call VSCodeNotify('workbench.action.closeActiveEditor')<CR>")

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


  vnoremap("J", ":call VSCodeNotifyVisual('editor.action.moveLinesDownAction', 0)<CR><Esc>jV")
  vnoremap("K", ":call VSCodeNotifyVisual('editor.action.moveLinesUpAction', 0)<CR><Esc>kV")
else
  nnoremap("<leader>w", ":up<CR>") -- Save the file if there where changes
  nnoremap("<leader>q", ":q<CR>")

  -- Move text
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

  -- Open file tree
  nnoremap("<leader>pv", "<cmd>Ex<CR>")
  nnoremap("<leader>e", "<cmd>Lex 30<CR>")

  -- UndoTree
  nnoremap("<leader>u", function() return vim.cmd("UndotreeToggle") end)

  -- Telescope
  nnoremap("<leader>f",
    "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>")
end
