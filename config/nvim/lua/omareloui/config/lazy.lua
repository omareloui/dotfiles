-- Bootstrap lazy.nvim {{{
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)
-- }}}

local lazy_ok, lazy = pcall(require, "lazy")

if not lazy_ok then
  return
end

local opts = {
  ui = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  rtp = {
    disabled_plugins = {
      "2html_plugin",
      "getscript",
      "getscriptPlugin",
      "gzip",
      "logipat",
      "netrw",
      "netrwPlugin",
      "netrwSettings",
      "netrwFileHandlers",
      "matchit",
      "tar",
      "tarPlugin",
      "rrhelper",
      "spellfile_plugin",
      "vimball",
      "vimballPlugin",
      "zip",
      "zipPlugin",
      "tutor",
      "rplugin",
      "syntax",
      "synmenu",
      "optwin",
      "compiler",
      "bugreport",
      "ftplugin",
    },
  },
}

lazy.setup("omareloui.plugins", opts)
