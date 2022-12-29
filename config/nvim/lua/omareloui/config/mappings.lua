local set = vim.keymap.set

---- Basic {{{

-- Navigate Insert Mode {{{
set("i", "jk", "<Esc>", { desc = "exit insert mode", nowait = true })
set("i", "Jk", "<Esc>", { desc = "exit insert mode", nowait = true })
set("i", "jK", "<Esc>", { desc = "exit insert mode", nowait = true })
set("i", "JK", "<Esc>", { desc = "exit insert mode", nowait = true })

set("i", "<C-h>", "<Left>", { desc = "move left", nowait = true })
set("i", "<C-j>", "<Down>", { desc = "move down", nowait = true })
set("i", "<C-k>", "<Up>", { desc = "move up", nowait = true })
set("i", "<C-l>", "<Right>", { desc = "move right", nowait = true })

set("i", "<C-b>", "<Esc>^i>", { desc = "move to the begining of the line" })
set("i", "<C-e>", "<End>", { desc = "move to the end of the line" })
-- }}}

-- Navigate Normal Mode {{{
-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
set({ "n", "x" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
set({ "n", "x" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
set({ "n", "v" }, "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
set({ "n", "v" }, "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
-- }}}

-- Highlight {{{
set("n", "<leader>n", "<Cmd>noh<CR>", { desc = "remove highlight" })
set("n", "<Esc>", "<Cmd>noh<CR>", { desc = "remove highlight" })
-- }}}

-- Indenting {{{
set("v", "<", "<gv", { desc = "indend line backwards" })
set("v", ">", ">gv", { desc = "indend line forwards" })
-- }}}

-- keep the cursor on the same position
-- set("v", "J", "mzJ`z", { desc = "merge with next line" })

-- Buffers {{{
local bufferline_buffers = function()
  set("n", "<C-S-Right>", "<Cmd>BufferLineMoveNext<CR>", { desc = "move the tab to the right", silent = true })
  set("n", "<C-S-Left>", "<Cmd>BufferLineMovePrev<CR>", { desc = "move the tab to the left", silent = true })

  set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "go to next buffer" })
  set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "go to previous buffer" })

  set("n", "<leader>bo", function()
    for _, e in ipairs(require("bufferline").get_elements().elements) do
      if e.id ~= vim.api.nvim_buf_get_number(0) then
        vim.api.nvim_buf_delete(e.id, {})
      end
    end
  end, { desc = "close all other buffers", silent = true })

  set("n", "<leader>bx", function()
    for _, e in ipairs(require("bufferline").get_elements().elements) do
      vim.api.nvim_buf_delete(e.id, {})
    end
  end, { desc = "close all buffers", silent = true })
end

set("n", "<C-s>", "<Cmd>up<CR>", { desc = "save buffer" })
set("n", "<leader>w", "<Cmd>up<CR>", { desc = "save buffer" })

set("n", "<C-c>", "<Cmd>%y+<CR>", { desc = "copy the whole file" })

set("n", "<leader>q", function()
  vim.schedule(function()
    vim.cmd "bd"
  end)
end, { desc = "close buffer", silent = true })
-- }}}

-- Clipboard {{{
set("n", "Y", "y$", { desc = "yank to the end of the line" })
set({ "n", "v" }, "<leader>y", '"+y', { desc = "yank to the system clipboard" })
set("n", "<leader>Y", '"+Y', { desc = "yank to the system clipboard" })
set({ "n", "v" }, "<leader>p", '"+p', { desc = "paste from the system clipboard" })
set("n", "<leader>P", '"+P', { desc = "paste from the system clipboard" })
-- set({ "n", "v" }, "<leader>d", '"_d', { desc = "delete to void" })
-- set("n", "<leader>D", '"_D', { desc = "delete to void" })
-- set("v", ",p", '"0p', { desc = "paste last yanked" })

-- Don't copy the replaced text after pasting in visual mode
set({ "x" }, "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true })
-- }}}

-- Navigation in file {{{
-- keep the cursor in the center of the screen
set("n", "<C-d>", "<C-d>zz", { desc = "move down half a page" })
set("n", "<C-u>", "<C-u>zz", { desc = "move up half a page" })
set("n", "n", "nzzzv", { desc = "find next" })
set("n", "N", "Nzzzv", { desc = "find previous" })
-- }}}

-- Text Manipulation {{{
set("n", "<leader>su", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "replace current word" })

set("n", "<leader>j", "<Cmd>m .+1<CR>==", { desc = "move the line down" })
set("n", "<leader>k", "<Cmd>m .-2<CR>==", { desc = "move the line up" })
set("v", "J", "<Cmd>m '>+1<CR>gv=gv", { desc = "move the line down" })
set("v", "K", "<Cmd>m '<-2<CR>gv=gv", { desc = "move the line up" })

-- set("i", "<C-j>", "<Cmd>m .+1<CR>==", { desc = "move the line down" })
-- set("i", "<C-k>", "<Cmd>m .-2<CR>==", { desc = "move the line up" })

set("n", "<A-j>", "yyp", { desc = "duplicate line down" })
set("n", "<A-k>", "yyP", { desc = "duplicate line up" })
-- }}}

-- Window {{{
set("n", "<C-j>", "<C-w>j", { desc = "go to down window" })
set("n", "<C-k>", "<C-w>k", { desc = "go to up window" })
set("n", "<C-h>", "<C-w>h", { desc = "go to left window" })
set("n", "<C-l>", "<C-w>l", { desc = "go to right window" })

set("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "split window vertically" })
set("n", "<leader>sh", "<Cmd>split<CR>", { desc = "split window horizontally" })
set("n", "<leader>se", "<C-w>=", { desc = "make the splits equal" })
set("n", "<leader>sm", "<Cmd>MaximizerToggle", { desc = "toggle maximizing the current window" })

set("n", "<leader>s>", "<Cmd>resize +5|vertical resize +5<CR>", { desc = "increase size of current window" })
set("n", "<leader>s<", "<Cmd>resize -5|vertical resize -5<CR>", { desc = "decrease size of current window" })

-- }}}

---- }}}

---- Plugins {{{
M = {}

-- LSP {{{
M.lsp = function(buffer_number)
  buffer_number = buffer_number or 0

  local d = vim.diagnostic
  local l = vim.lsp

  set("n", "<leader>dp", d.goto_prev, { desc = "go to previous diagnostic", buffer = buffer_number })
  set("n", "<leader>dn", d.goto_next, { desc = "go to next diagnostic", buffer = buffer_number })
  set("n", "<leader>ds", d.setloclist, { desc = "diagnostic setloclist", buffer = buffer_number })
  set("n", "<leader>df", d.open_float, { desc = "floating diagnostic", buffer = buffer_number })

  set("n", "gt", l.buf.type_definition, { desc = "lsp definition type", buffer = buffer_number })
  set("n", "gi", l.buf.implementation, { desc = "lsp implementation", buffer = buffer_number })
  set("n", "gD", l.buf.declaration, { desc = "lsp dclaration", buffer = buffer_number })
  set("n", "gd", l.buf.definition, { desc = "lsp definition", buffer = buffer_number })
  set("n", "gr", l.buf.references, { desc = "lsp references", buffer = buffer_number })

  set("n", "K", l.buf.hover, { desc = "lsp hover" })

  -- TODO: uncomment after getting the package
  -- set("n", "<leader>lr", require("nvchad_ui.rename").open, { desc = "rename the current variable/function", buffer = buffer_number })
  set("n", "<leader>ls", l.buf.signature_help, { desc = "lsp signature_help", buffer = buffer_number })
  set("n", "<leader>la", l.buf.code_action, { desc = "lsp code_action", buffer = buffer_number })

  set("n", "<leader>lwa", l.buf.add_workspace_folder, { desc = "add lsp workspace folder", buffer = buffer_number })
  set(
    "n",
    "<leader>lwr",
    l.buf.remove_workspace_folder,
    { desc = "remove lsp workspace folder", buffer = buffer_number }
  )
  set("n", "<leader>lwl", l.buf.list_workspace_folders, { desc = "list lsp workspace folders", buffer = buffer_number })
end

local telescope_lsp = function()
  set("n", "<leader>dl", "<Cmd>Telescope diagnostics<CR>", { desc = "list all diagnostics", buffer = 0 })
end
-- }}}

--- Cmp {{{
M.cmp = function(cmp)
  return {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-c>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
    ["<C-Space>"] = cmp.mapping.complete(),

    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif require("luasnip").expand_or_jumpable() then
    --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif require("luasnip").jumpable(-1) then
    --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
  }
end
--- }}}

-- NvimTree {{{
M.nvimtree = function()
  set("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "toggle NvimTree" })
end
-- }}}

-- UndoTree {{{
M.undotree = function()
  -- TODO: why did I wrote it like this!! not <Cmd>UndotreeToggle<CR>
  set("n", "<leader>u", function()
    return vim.cmd "UndotreeToggle"
  end, { desc = "open Undotree" })
end
-- }}}

--- BufferLine {{{
M.bufferline = function()
  bufferline_buffers()
end
--- }}}

-- Git {{{
local schedule = vim.schedule
local diff = vim.wo.diff

local terminal_git = function()
  set("n", "<leader>gg", "<Cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "open lazygit" })
end

local telescope_git = function()
  set("n", "<leader>gl", "<Cmd>Telescope git_bcommits<CR>", { desc = "git commits" })
  set("n", "<leader>gs", "<Cmd>Telescope git_status<CR>", { desc = "git status" })
  set("n", "<leader>gs", "<Cmd>Telescope git_status<CR>", { desc = "git status" })
end

M.gitsings = function()
  set("n", "<leader>gd", "<Cmd>Gvdiffsplit<CR>", { desc = "git diff" })

  set("n", "<leader>gb", function()
    require("gitsigns").blame_line { full = true }
  end, { desc = "git blame line" })
  set("n", "<leader>gp", require("gitsigns").preview_hunk, { desc = "git preview hunk" })

  set("n", "<leader>ghr", require("gitsigns").reset_hunk, { desc = "reset hunk" })
  set("n", "<leader>ghd", require("gitsigns").toggle_deleted, { desc = "toggle show deleted from git" })

  set("n", "<leader>ghn", function()
    if diff then
      return "<leader>ghn"
    end
    schedule(require("gitsigns").next_hunk)
    return "<Ignore>"
  end, { desc = "jump to next hunk", expr = true })
  set("n", "<leader>ghp", function()
    if diff then
      return "<leader>ghp"
    end
    schedule(require("gitsigns").prev_hunk)
    return "<Ignore>"
  end, { desc = "jump to previous hunk", expr = true })
end
-- }}}

-- Telescope {{{
M.telescope = function()
  set("n", "<leader>fa", "<Cmd>Telescope find_files follow=truw no_ignore=true hidden=true<CR>", { desc = "find all" })
  set("n", "<leader>ff", "<Cmd>Telescope find_files<CR>", { desc = "find files" })
  set("n", "<leader>fo", "<Cmd>Telescope oldfiles<CR>", { desc = "find in recent opened files" })

  set("n", "<leader>fw", "<Cmd>Telescope live_grep<CR>", { desc = "live grep" })
  set("n", "<leader>fb", "<Cmd>Telescope buffers<CR>", { desc = "search in buffers" })
  set("n", "<leader>fh", "<Cmd>Telescope help_tags<CR>", { desc = "find in help tags" })
  set("n", "<leader>fk", "<Cmd>Telescope keymaps<CR>", { desc = "show key mappings" })
  set(
    "n",
    "<leader>fn",
    "<Cmd>Telescope file_browser files=false hide_parent_dir=true<CR>",
    { desc = "open file browser" }
  )
  set(
    "n",
    "<leader>ft",
    "<Cmd>Telescope file_browser hidden=true repect_gitignore=false collapse_dirs=true<CR>",
    { desc = "open file browser" }
  )
  set("n", "<leader>fr", "<Cmd>Telescope file_browser cwd=~/repos<CR>", { desc = "open all repos" })

  telescope_git()
  telescope_lsp()
end
-- }}}

-- TodoComments {{{
M.todo_comments = function()
  set("n", "]t", require("todo-comments").jump_next, { desc = "next todo comment" })
  set("n", "[t", require("todo-comments").jump_prev, { desc = "previous todo comment" })
end
-- }}}

-- Snippets {{{
M.snippets = function()
  set(
    "n",
    "<leader><leader>s",
    "<Cmd>source ~/.config/nvim/lua/omareloui/snippets/init.lua<CR>",
    { desc = "source the snippets file" }
  )
  set({ "i", "s" }, "<C-k>", function()
    local ls = require "luasnip"
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { desc = "expand the snippet or jump to the next snippet placeholder", silent = true })
  set({ "i", "s" }, "<C-j>", function()
    local ls = require "luasnip"
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { desc = "jump to the previous placeholder", silent = true })
  set({ "i", "s" }, "<C-l>", function()
    local ls = require "luasnip"
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { desc = "cycle in snippet's options", silent = true })
end
-- }}}

-- Comments {{{
M.comments = function()
  set("n", "<leader>/", require("Comment.api").toggle.linewise.current, { desc = "toggle comment" })
  set(
    "v",
    "<leader>/",
    "<Esc><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "toggle comment" }
  )
end
-- }}}

-- Terminal {{{
M.terminal = function()
  terminal_git()
  set("n", "<leader>tt", "<Cmd>lua _TERMINAL_TOGGLE()<CR>", { desc = "toggle the terminal" })
end

M.terminal_when_active = function()
  local set_buf_keymap = vim.api.nvim_buf_set_keymap

  -- set_buf_keymap(0, "t", "<esc>", [[<C-\><C-n>]], { desc = "close the terminal" })
  -- set_buf_keymap(0, "t", "jk", [[<C-\><C-n>]], { desc = "close the terminal" })
  set_buf_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], { desc = "close the terminal" })
  set_buf_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], { desc = "close the terminal" })
  -- set_buf_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], { desc = "close the terminal" })
  -- set_buf_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], { desc = "close the terminal" })
end
-- }}}

return M
---- }}}
