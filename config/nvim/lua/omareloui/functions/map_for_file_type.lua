local bind = require("omareloui.functions.keymap").bind
local inoremap = require("omareloui.functions.keymap").inoremap

local M = {}

-----------------------------------
-- VIM
local cmd = vim.cmd

-- Highlight on yank
-- cmd [[
--   augroup YankHighlight
--     autocmd!
--     autocmd TextYankPost * silent! lua vim.highlight.on_yank()
--   augroup end
-- ]]


-- LUA
-- local api = vim.api
--
-- -- Highlight on yank
-- local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
-- api.nvim_create_autocmd("TextYankPost", {
--   command = "silent! lua vim.highlight.on_yank()",
--   group = yankGrp,
-- })
-------------------------------------

-- IN VIM
-- -- All previous macros have been changed to autocmd, @g macro will run current file
-- vim.cmd [[
-- 	augroup run_file
-- 		autocmd BufEnter *.java let @g=":w\<CR>:vsp | terminal java %\<CR>i"
-- 		autocmd BufEnter *.py let @g=":w\<CR>:vsp |terminal python %\<CR>i"
-- 		autocmd BufEnter *.asm let @g=":w\<CR> :!nasm -f elf64 -o out.o % && ld out.o -o a.out \<CR> | :vsp |terminal ./a.out\<CR>i"
-- 		autocmd BufEnter *.cpp let @g=":w\<CR> :!g++ -std=c++17 -O3 %\<CR> | :vsp |terminal ./a.out\<CR>i"
-- 		autocmd BufEnter *.c let @g=":w\<CR> :!gcc -O3 -std=gnu99 -Wno-deprecated-declarations -pedantic -Wall -Wextra %\<CR> | :vsp |terminal ./a.out\<CR>i"
-- 		autocmd BufEnter *.go let @g=":w\<CR> :vsp | terminal go run % \<CR>i"
-- 		autocmd BufEnter *.js let @g=":w\<CR> :vsp | terminal node % \<CR>i"
-- 		autocmd BufEnter *.html let @g=":w\<CR> :silent !chromium % \<CR>"
-- 	augroup end
-- ]]

-- In LUA
-- -- windows to close with "q"
-- api.nvim_create_autocmd(
--   "FileType",
--   { pattern = { "help", "startuptime", "qf", "lspinfo" }, command = [[nnoremap <buffer><silent> q :close<CR>]] }
-- )
-- api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = { "help", "startuptime", "qf", "lspinfo" },
    -- command = [[nnoremap <buffer><silent> q :close<CR>]]
    command = [[lua print(v.b.FileType)]]
  }
)
-- vim.api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })


-- local function bind(op, outer_opts)
local function bind_file_type(mode, outer_opts)
  outer_opts = outer_opts or { noremap = true }
  return function(file_type, lhs, rhs, opts, set_func)
    -- set_func = set_func or vim.keymap.set
    -- opts = vim.tbl_extend("force",
    --   outer_opts,
    --   opts or {}
    -- )
    -- set_func(op, lhs, rhs, opts)
  end
end

-- M.ft_nnoremap = bind_file_type()

--[[
-- CODE RUNNER

local function code_keymap()
  if vim.fn.has "nvim-0.7" then
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        vim.schedule(CodeRunner)
      end,
    })
  else
    vim.cmd "autocmd FileType * lua CodeRunner()"
  end

  function CodeRunner()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local fname = vim.fn.expand "%:p:t"
    local keymap_c = {}

    if ft == "python" then
      keymap_c = {
        name = "Code",
        r = { "<cmd>update<CR><cmd>exec '!python3' shellescape(@%, 1)<cr>", "Run" },
        m = { "<cmd>TermExec cmd='nodemon -e py %'<cr>", "Monitor" },
      }
    elseif ft == "lua" then
      keymap_c = {
        name = "Code",
        r = { "<cmd>luafile %<cr>", "Run" },
      }
    elseif ft == "rust" then
      keymap_c = {
        name = "Code",
        r = { "<cmd>Cargo run<cr>", "Run" },
        D = { "<cmd>RustDebuggables<cr>", "Debuggables" },
        h = { "<cmd>RustHoverActions<cr>", "Hover Actions" },
        R = { "<cmd>RustRunnables<cr>", "Runnables" },
      }
    elseif ft == "go" then
      keymap_c = {
        name = "Code",
        r = { "<cmd>GoRun<cr>", "Run" },
      }
    elseif ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
      keymap_c = {
        name = "Code",
        o = { "<cmd>TSLspOrganize<cr>", "Organize" },
        r = { "<cmd>TSLspRenameFile<cr>", "Rename File" },
        i = { "<cmd>TSLspImportAll<cr>", "Import All" },
        R = { "<cmd>lua require('config.test').javascript_runner()<cr>", "Choose Test Runner" },
        s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" },
        t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" },
      }
    end

    if fname == "package.json" then
      keymap_c.v = { "<cmd>lua require('package-info').show()<cr>", "Show Version" }
      keymap_c.c = { "<cmd>lua require('package-info').change_version()<cr>", "Change Version" }
      keymap_c.s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" }
      keymap_c.t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" }
    end

    if next(keymap_c) ~= nil then
      whichkey.register(
        { c = keymap_c },
        { mode = "n", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>" }
      )
    end
  end
end
]]

return M
