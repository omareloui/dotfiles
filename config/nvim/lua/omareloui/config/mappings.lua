local set = vim.keymap.set

-- Navigate insert mode
set({ "i" }, "jk", "<Esc>", { desc = "Exit insert mode", nowait = true })

set("i", "<C-h>", "<Left>", { desc = "Move left", nowait = true })
set("i", "<C-j>", "<Down>", { desc = "Move down", nowait = true })
set("i", "<C-k>", "<Up>", { desc = "Move up", nowait = true })
set("i", "<C-l>", "<Right>", { desc = "Move right", nowait = true })

set("i", "<C-b>", "<Esc>^i>", { desc = "Move to the beginning of the line" })
set("i", "<C-e>", "<End>", { desc = "Move to the end of the line" })

set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Indenting
set("v", "<", "<gv", { desc = "Indend line backwards" })
set("v", ">", ">gv", { desc = "Indend line forwards" })

-- keep the cursor on the same position
set("n", "J", "mzJ`z", { desc = "Merge with next line" })

-- Buffers
local bufferline_buffers = function()
  set("n", "<C-S-Right>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move the tab to the right", silent = true })
  set("n", "<C-S-Left>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move the tab to the left", silent = true })

  set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Go to next buffer" })
  set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Go to previous buffer" })

  set("n", "<leader>bo", function()
    for _, e in ipairs(require("bufferline").get_elements().elements) do
      if e.id ~= vim.api.nvim_buf_get_number(0) then
        vim.api.nvim_buf_delete(e.id, {})
      end
    end
  end, { desc = "Close all other buffers", silent = true })

  set("n", "<leader>bx", function()
    for _, e in ipairs(require("bufferline").get_elements().elements) do
      vim.api.nvim_buf_delete(e.id, {})
    end
  end, { desc = "Close all buffers", silent = true })
end

set("n", "<C-s>", "<Cmd>up<CR>", { desc = "Save buffer" })
set("n", "<leader>w", "<Cmd>up<CR>", { desc = "Save buffer" })

set("n", "<leader>q", function()
  vim.schedule(function()
    vim.cmd "bd"
  end)
end, { desc = "Close buffer", silent = true })

-- Clipboard
set("n", "Y", "y$", { desc = "Yank to the end of the line", remap = true })
set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to the system clipboard", remap = true })
set("n", "<leader>Y", '"+Y', { desc = "Yank to the system clipboard", remap = true })
set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from the system clipboard", remap = true })
set("n", "<leader>P", '"+P', { desc = "Paste from the system clipboard", remap = true })

-- Don't copy the replaced text after pasting in visual mode
set("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true, remap = true })

-- Navigation in file
-- keep the cursor in the center of the screen
set("n", "<C-d>", "<C-d>zz", { desc = "Move down half a page" })
set("n", "<C-u>", "<C-u>zz", { desc = "Move up half a page" })
set("n", "n", "nzzzv", { desc = "Find next" })
set("n", "N", "Nzzzv", { desc = "Find previous" })

-- Text Manipulation
set("n", "<leader>su", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace current word" })

set("n", "<leader>j", "<Cmd>m .+1<CR>==", { desc = "Move the line down" })
set("n", "<leader>k", "<Cmd>m .-2<CR>==", { desc = "Move the line up" })
set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move the line down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move the line up" })

set("n", "<A-j>", "yyp", { desc = "Duplicate line down" })
set("n", "<A-k>", "yyP", { desc = "Duplicate line up" })

-- Window
set("n", "<C-j>", "<C-w>j", { desc = "Go to down window" })
set("n", "<C-k>", "<C-w>k", { desc = "Go to up window" })
set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

set("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "Split window vertically" })
set("n", "<leader>sh", "<Cmd>split<CR>", { desc = "Split window horizontally" })
set("n", "<leader>se", "<C-w>=", { desc = "Make the splits equal" })
set("n", "<leader>sm", "<Cmd>MaximizerToggle<CR>", { desc = "Toggle maximizing the current window" })

-- map("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
-- map("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
-- map("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
-- map("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

set("n", "<leader>s>", "<Cmd>resize +5|vertical resize +5<CR>", { desc = "Increase size of current window" })
set("n", "<leader>s<", "<Cmd>resize -5|vertical resize -5<CR>", { desc = "Decrease size of current window" })

---- Plugins
local M = {}

-- LSP
M.lsp = function(buffer_number)
  buffer_number = buffer_number or 0

  local d = vim.diagnostic
  local l = vim.lsp

  local opts = { desc = "Diagnostic setloclist", buffer = buffer_number }

  opts.desc = "Diagnostic setloclist"
  set("n", "<leader>ds", d.setloclist, opts)

  opts.desc = "Floating diagnostic"
  set("n", "<leader>df", d.open_float, opts)

  opts.desc = "Lsp definition type"
  set("n", "gt", l.buf.type_definition, opts)

  opts.desc = "Lsp definition type"
  set("n", "gi", l.buf.implementation, opts)

  opts.desc = "Lsp definition"
  set("n", "gd", l.buf.definition, opts)

  opts.desc = "Go to declaration"
  set("n", "gD", l.buf.declaration, opts)

  opts.desc = "Show LSP references"
  set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

  opts.desc = "See available code actions"
  set({ "n", "v" }, "<leader>ca", l.buf.code_action, opts)

  opts.desc = "Smart rename"
  set("n", "<leader>rn", l.buf.rename, opts)

  opts.desc = "Show buffer diagnostics"
  set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

  opts.desc = "Go to previous diagnostic"
  set("n", "[d", vim.diagnostic.goto_prev, opts)

  opts.desc = "Go to next diagnostic"
  set("n", "]d", vim.diagnostic.goto_next, opts)

  opts.desc = "Show documentation for what is under cursor"
  set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

  set("n", "<leader>ls", l.buf.signature_help, { desc = "Lsp signature_help", buffer = buffer_number })

  set("n", "<leader>lwa", l.buf.add_workspace_folder, { desc = "Add lsp workspace folder", buffer = buffer_number })
  set(
    "n",
    "<leader>lwr",
    l.buf.remove_workspace_folder,
    { desc = "Remove lsp workspace folder", buffer = buffer_number }
  )
  set("n", "<leader>lwl", l.buf.list_workspace_folders, { desc = "List lsp workspace folders", buffer = buffer_number })

  set("n", "<leader>rs", "<Cmd>LspRestart<CR>", { desc = "Restart the lsp server", buffer = buffer_number })
end

M.rust_tools = function(bufnr)
  local rust_tools = require "rust-tools"
  bufnr = bufnr or 0

  set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
  set("n", "<Leader>la", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
end

M.markdown_preview = function()
  return {
    {
      "<leader>cp",
      ft = "markdown",
      "<Cmd>MarkdownPreviewToggle<CR>",
      desc = "Markdown Preview",
    },
  }
end

M.tsserver = function()
  set("n", "<leader>co", function()
    vim.lsp.buf.code_action {
      apply = true,
      context = {
        only = { "source.organizeImports.ts" },
        diagnostics = {},
      },
    }
  end, { desc = "Organize Imports" })

  set("n", "<leader>cR", function()
    vim.lsp.buf.code_action {
      apply = true,
      context = {
        only = { "source.removeUnused.ts" },
        diagnostics = {},
      },
    }
  end, { desc = "Remove Unused Imports" })
end

M.lspsaga = function()
  set("n", "gh", "<Cmd>Lspsaga finder ref<CR>", { silent = true })

  set({ "n", "v" }, "<leader>la", "<Cmd>Lspsaga code_action<CR>", { silent = true })
  set("n", "<leader>lr", "<Cmd>Lspsaga rename<CR>", { silent = true })

  set("n", "<leader>lp", "<Cmd>Lspsaga peek_definition<CR>", { silent = true })

  set("n", "<leader>df", "<Cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
  set("n", "<leader>dc", "<Cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

  set("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
  set("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

  set("n", "<leader>dP", function()
    require("lspsaga.diagnostic").goto_prev { severity = vim.diagnostic.severity.ERROR }
  end, { silent = true })
  set("n", "<leader>dN", function()
    require("lspsaga.diagnostic").goto_next { severity = vim.diagnostic.severity.ERROR }
  end, { silent = true })

  set("n", "<leader>lo", "<Cmd>LSoutlineToggle<CR>", { silent = true })
  set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", { silent = true })
end

local telescope_lsp = function()
  set("n", "<leader>dl", "<Cmd>Telescope diagnostics<CR>", { desc = "List all diagnostics", buffer = true })
end

-- Formatting
M.conform = function(conform, opts)
  set({ "n", "v" }, "<leader>mp", function()
    conform.format(opts)
  end, { desc = "Format file or range (in visual mode)" })
end

-- Linting
M.lint = function(lint)
  set("n", "<leader>ll", function()
    lint.try_lint()
  end, { desc = "Trigger linting for current file." })
end

--- Cmp
M.cmp = function(cmp)
  return {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
  }
end

-- Spectre
M.spectre = function()
  return {
    {
      "<leader>sr",
      function()
        require("spectre").open()
      end,
      desc = "Replace in files (Spectre)",
    },
  }
end

-- File Browsing
M.nvimtree = function()
  set("n", "<leader>e", require("nvim-tree.api").tree.toggle, { desc = "toggle NvimTree" })
end

-- UndoTree
M.undotree = function()
  set("n", "<leader>u", "<Cmd>UndotreeToggle<CR>", { desc = "open Undotree" })
end

-- BufferLine
M.bufferline = function()
  bufferline_buffers()
end

-- TreeSitter TextObjects
M.treesitter_text_objects = {
  select = {
    ["af"] = { query = "@function.outer", desc = "select outer part of a function" },
    ["if"] = { query = "@function.inner", desc = "select inner part of a function" },

    ["ic"] = { query = "@class.inner", desc = "select inner part of a class" },
    ["ac"] = { query = "@class.outer", desc = "select outer part of a class" },

    ["il"] = { query = "@loop.inner", desc = "select inner part of a loop" },
    ["al"] = { query = "@loop.outer", desc = "select outer part of a loop" },

    ["ii"] = { query = "@conditional.inner", desc = "select inner part of a conditional" },
    ["ai"] = { query = "@conditional.outer", desc = "select outer part of a conditional" },

    ["ib"] = { query = "@block.inner", desc = "select inner part of a block" },
    ["ab"] = { query = "@block.outer", desc = "select outer part of a block" },

    ["ir"] = { query = "@parameter.inner", desc = "select inner part of a parameter" },
    ["ar"] = { query = "@parameter.outer", desc = "select outer part of a parameter" },
  },
  swap = {
    next = {
      ["<leader>a"] = { query = "@parameter.inner", desc = "swap with the next parameter" },
    },
    prev = {
      ["<leader>A"] = { query = "@parameter.inner", desc = "swap with the previous parameter" },
    },
  },
  goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
  goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
  goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
  goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },

  init_selection = "<C-Space><C-Space>",
  node_incremental = "<C-Space>",
  node_decremental = "<BS>",
}

-- Git
local terminal_git = function()
  set("n", "<leader>gg", "<Cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "open lazygit" })
end

local telescope_git = function()
  set("n", "<leader>gs", "<Cmd>Telescope git_status<CR>", { desc = "git status" })
  set("n", "<leader>gs", "<Cmd>Telescope git_status<CR>", { desc = "git status" })
end

M.gitsings = function()
  local gs = require "gitsigns"

  -- stylua: ignore start
  set({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
  set({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })

  set("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer" })
  set("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
  set("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer" })
  set("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview Hunk" })
  set("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })
  set("n", "<leader>ghd", gs.diffthis, { desc = "Diff This" })
  set("n", "<leader>ghD", function() gs.diffthis("~") end, { desc = "Diff This ~" })
  set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns Select Hunk" })

  set("n", "]h", gs.next_hunk, { desc = "Next Hunk" })
  set("n", "[h", gs.prev_hunk, { desc = "Prev Hunk" })
end

function M.fugitive()
  set("n", "<leader>gd", "<Cmd>Gvdiffsplit<CR>", { desc = "git diff" })
  set("n", "<leader>gl", "<Cmd>GcLog -10<CR>", { desc = "git logs" })
  set("n", "<leader>gfl", "<Cmd>Git log -p --follow -- %<CR>", { desc = "git file log" })
end

-- Telescope
M.telescope = function()
  set("n", "<leader>fa", "<Cmd>Telescope find_files follow=true hidden=true<CR>", { desc = "find files" })
  -- set("n", "<leader>ff", "<Cmd>Telescope find_files follow=true hidden=true<CR>", { desc = "find files" })
  -- set("n", "<leader>fa", "<Cmd>Telescope find_files follow=true hidden=true no_ignore=true<CR>", { desc = "find all" })

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

-- TodoComments
M.todo_comments = function()
  return {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next todo comment",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous todo comment",
    },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  }
end

-- Snippets
M.snippets = function()
  set(
    "n",
    "<leader><leader>s",
    "<Cmd>source ~/.config/nvim/lua/omareloui/config/snippets/init.lua<CR>",
    { desc = "source the snippets file" }
  )
  set({ "i", "s" }, "<C-j>", function()
    local ls = require "luasnip"
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { desc = "expand the snippet or jump to the next snippet placeholder", silent = true })
  set({ "i", "s" }, "<C-k>", function()
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
  end, { desc = "cycle in snippet's options right", silent = true })
  set({ "i", "s" }, "<C-h>", function()
    local ls = require "luasnip"
    if ls.choice_active() then
      ls.change_choice(-1)
    end
  end, { desc = "cycle in snippet's options left", silent = true })
end

-- Comments
-- M.comments = function()
--   set("n", "<leader>/", require("Comment.api").toggle.linewise.current, { desc = "toggle comment" })
--   set(
--     "v",
--     "<leader>/",
--     "<Esc><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
--     { desc = "toggle comment" }
--   )
-- end

-- Terminal
M.terminal = function()
  terminal_git()
end

M.terminal_when_active = function()
  local set_buf_keymap = vim.api.nvim_buf_set_keymap

  -- set_buf_keymap(0, "t", "<esc>", [[<C-\><C-n>]], { desc = "close the terminal" })
  -- set_buf_keymap(0, "t", "jk", [[<C-\><C-n>]], { desc = "close the terminal" })
  set_buf_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], { desc = "close the terminal" })
  set_buf_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], { desc = "close the terminal" })
  -- set_buf_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], { desc = "close the terminal" })
  -- set_buf_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]])
end

-- Rexplainer
function M.regexplainer()
  return {
    toggle = "<leader>rp",
    show_popup = "<leader>rp",
    show_split = "<leader>rs",
    hide = "<leader>rq",
  }
end

-- Rest
function M.rest()
  set("n", "<leader>ro", "<Plug>RestNvim", { desc = "run the request under the cursor" })
  set("n", "<leader>rv", "<Plug>RestNvimPreview", { desc = "preview the request cURL command" })
  set("n", "<leader>rl", "<Plug>RestNvimLast", { desc = "re-run the last request" })
end

-- Toggler
function M.toggler()
  set(
    { "n", "v" },
    "<leader>i",
    require("nvim-toggler").toggle,
    { desc = "Toggle the cursor word (eg. from true to false)" }
  )
end

-- Yank
function M.yanky()
  return {
    {
      "<leader>p",
      function()
        require("telescope").extensions.yank_history.yank_history {}
      end,
      desc = "Open Yank History",
    },
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
    { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
    { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
    { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
    { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
    { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
    { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
    { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
    { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
    { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
    { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
    { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
    { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
    { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
    { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
  }
end

-- Portal
function M.portal()
  set("n", "<leader>o", require("portal").jump_backward, { desc = "jump backward using portal" })
  set("n", "<leader>i", require("portal").jump_forward, { desc = "jump forward using portal" })
end

-- UFO
function M.ufo()
  set("n", "zR", require("ufo").openAllFolds)
  set("n", "zM", require("ufo").closeAllFolds)
end

return M
