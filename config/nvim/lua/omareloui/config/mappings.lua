local set = require("omareloui.util.keymap").set

-- Navigate insert mode
set("jk", "<Esc>", "Exit insert mode", { nowait = true, mode = { "i" } })

set("<C-h>", "<Left>", "Move left", { nowait = true, mode = { "i" } })
set("<C-j>", "<Down>", "Move down", { nowait = true, mode = { "i" } })
set("<C-k>", "<Up>", "Move up", { nowait = true, mode = { "i" } })
set("<C-l>", "<Right>", "Move right", { nowait = true, mode = { "i" } })

set("k", "v:count == 0 ? 'gk' : 'k'", "Move up", { expr = true, silent = true, mode = { "n", "x" } })
set("j", "v:count == 0 ? 'gj' : 'j'", "Move down", { expr = true, silent = true, mode = { "n", "x" } })
set("<Up>", "v:count == 0 ? 'gk' : 'k'", "Move up", { expr = true, silent = true, mode = { "n", "x" } })
set("<Down>", "v:count == 0 ? 'gj' : 'j'", "Move down", { expr = true, silent = true, mode = { "n", "x" } })

-- Indenting
set("<", "<gv", "Indend line backwards", { mode = { "v" } })
set(">", ">gv", "Indend line forwards", { mode = { "v" } })

-- keep the cursor on the same position
set("J", "mzJ`z", "Merge with next line")

set("<C-s>", "<Cmd>up<CR>", "Save buffer")
set("<leader>w", "<Cmd>up<CR>", "Save buffer")
set("<leader>nf", "<Cmd>noa up<CR>", "Save buffer without formatting")

-- stylua: ignore
set("<leader>q", function() vim.schedule(function() vim.cmd "bd" end) end, "Close buffer", { silent = true })

-- Clipboard
set("Y", "y$", "Yank to the end of the line", { remap = true })
set("<leader>y", '"+y', "Yank to the system clipboard", { remap = true, mode = { "n", "v" } })
set("<leader>Y", '"+Y', "Yank to the system clipboard", { remap = true })
set("<leader>p", '"+p', "Paste from the system clipboard", { remap = true, mode = { "n", "v" } })
set("<leader>P", '"+P', "Paste from the system clipboard", { remap = true })
set(
  "p",
  'p:let @+=@0<CR>:let @"=@0<CR>',
  "Paste without overwriting the register",
  { silent = true, remap = true, mode = "x" }
)

-- Navigation in file
-- keep the cursor in the center of the screen
set("<C-d>", "<C-d>zz", "Move down half a page")
set("<C-u>", "<C-u>zz", "Move up half a page")
set("n", "nzzzv", "Find next")
set("N", "Nzzzv", "Find previous")

-- Text Manipulation
set("<leader>su", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Replace current word")

set("<leader>j", "<Cmd>m .+1<CR>==", "Move the line down")
set("<leader>k", "<Cmd>m .-2<CR>==", "Move the line up")
set("K", ":m '<-2<CR>gv=gv", "Move the line up", { mode = { "v" } })
set("J", ":m '>+1<CR>gv=gv", "Move the line down", { mode = { "v" } })

set("<A-j>", '"dyy"dp', "Duplicate line down")
set("<A-k>", '"dyy"dP', "Duplicate line up")

-- Window
set("<C-j>", "<C-w>j", "Go to down window")
set("<C-k>", "<C-w>k", "Go to up window")
set("<C-h>", "<C-w>h", "Go to left window")
set("<C-l>", "<C-w>l", "Go to right window")

-- splits
set("<leader>sv", "<Cmd>vsplit<CR>", "Split window vertically")
set("<leader>sh", "<Cmd>split<CR>", "Split window horizontally")
set("<leader>se", "<C-w>=", "Make the splits equal")
set("<leader>sm", "<Cmd>MaximizerToggle<CR>", "Toggle maximizing the current window")

set("<leader>s+", "<Cmd>resize +2<CR>", "Increase window height")
set("<leader>s-", "<Cmd>resize -2<CR>", "Decrease window height")
set("<leader>s>", "<Cmd>vertical resize +2<CR>", "Increase window width")
set("<leader>s<", "<Cmd>vertical resize -2<CR>", "Decrease window width")
