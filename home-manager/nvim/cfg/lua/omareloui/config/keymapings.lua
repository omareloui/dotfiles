local set = require("omareloui.util.keymap").set

-- Navigate insert mode
-- set("jk", "<Esc>", "Exit insert mode", { nowait = true, mode = { "i" } })

set("k", "v:count == 0 ? 'gk' : 'k'", "Move up", { expr = true, silent = true, mode = { "n", "x" } })
set("j", "v:count == 0 ? 'gj' : 'j'", "Move down", { expr = true, silent = true, mode = { "n", "x" } })
set("<Up>", "v:count == 0 ? 'gk' : 'k'", "Move up", { expr = true, silent = true, mode = { "n", "x" } })
set("<Down>", "v:count == 0 ? 'gj' : 'j'", "Move down", { expr = true, silent = true, mode = { "n", "x" } })

-- Navigate buffers
set("<A-p>", "<Cmd>e#<CR>", "Last edited buffer")

-- Indenting
set("<", "<gv", "Indent line backwards", { mode = { "v" } })
set(">", ">gv", "Indent line forwards", { mode = { "v" } })

-- keep the cursor on the same position
set("J", "mzJ`z", "Merge with next line")

set("<leader>w", "<Cmd>up<CR>", "Save buffer")

set("<Esc>", "<Cmd>noh<CR>", "Exit highligh")

-- stylua: ignore
set("<leader>q", function() vim.schedule(function() vim.cmd "bd" end) end, "Close buffer", { silent = true })

-- Clipboard
set("<leader>y", '"+y', "Yank to the system clipboard", { remap = true, mode = { "n", "v" } })
set("<leader>Y", '"+Y', "Yank to the system clipboard", { remap = true })
set("<leader>p", '"+p', "Paste from the system clipboard", { remap = true, mode = { "n", "v" } })
set("<leader>P", '"+P', "Paste from the system clipboard", { remap = true })
set("p", 'p:let @"=@0<CR>', "Paste without overwriting the register", { silent = true, remap = true, mode = "x" })

-- Navigation in file
-- keep the cursor in the center of the screen
set("<C-d>", "<C-d>zz", "Move down half a page")
set("<C-u>", "<C-u>zz", "Move up half a page")
set("n", "nzzzv", "Find next")
set("N", "Nzzzv", "Find previous")

-- Recording
set("Q", "@qj", "Apply the q register")
set("Q", "<Cmd>norm @q<CR>", 'Apply the "q" register', { mode = "x" })

-- Text Manipulation
set("<leader>su", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Replace current word")

set("<leader>j", "<Cmd>m .+1<CR>==", "Move the line down")
set("<leader>k", "<Cmd>m .-2<CR>==", "Move the line up")
set("K", ":m '<-2<CR>gv=gv", "Move the line up", { mode = { "v" } })
set("J", ":m '>+1<CR>gv=gv", "Move the line down", { mode = { "v" } })
