local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local fn = vim.fn

-- Highlight word under cursor {{{
function HighlightWordUnderCursor()
  local disable_ft = { "qf", "fugitive", "nerdtree", "gundo", "diff", "fzf", "floaterm", "alpha" }
  local curr_ft = vim.api.nvim_buf_get_option(0, "filetype")

  for _, ft in pairs(disable_ft) do
    if ft == curr_ft then
      return
    end
  end

  local cword = fn.escape(fn.expand "<cword>", "/\\")
  fn.execute("match CursorMatchWord /\\V\\<" .. cword .. "\\>/")
end

local match_cursor_word_group = augroup("MatchCursorWord", { clear = true })
autocmd({ "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = HighlightWordUnderCursor,
  group = match_cursor_word_group,
  desc = "Highlight word under cursor",
})
-- }}}

-- Highlight yanked text {{{
function HighlightOnYank()
  vim.highlight.on_yank { higroup = "IncSearch", timeout = 40 }
end

local highlight_on_yank = augroup("HighlightOnYank", { clear = true })
autocmd("TextYankPost", {
  pattern = "*",
  callback = HighlightOnYank,
  group = highlight_on_yank,
  desc = "Highlight selection on yank",
})
-- }}}

-- Markdown syntax and zk keymaps {{{
local sytax_highlight_group = vim.api.nvim_create_augroup("MarkDownSyntaxConceal", {})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    require("omareloui.config.mappings").zk()

    vim.cmd [[
      " markdownWikiLink is a new region
      syn region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownUrl keepend oneline concealends
      " markdownLinkText is copied from runtime files with 'concealends' appended
      syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends
      " markdownLink is copied from runtime files with 'conceal' appended
      syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal

      """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
      " Src: https://github.com/prurigro/vim-markdown-concealed/blob/master/syntax/mkdc.vim
      " Headings
      syn spell toplevel
      syn case ignore
      syn sync linebreaks=1

      syn region htmlH1              matchgroup=mkdDelimiter start="^\s*#"                                  end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
      syn region htmlH2              matchgroup=mkdDelimiter start="^\s*##"                                 end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
      syn region htmlH3              matchgroup=mkdDelimiter start="^\s*###"                                end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
      syn region htmlH4              matchgroup=mkdDelimiter start="^\s*####"                               end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
      syn region htmlH5              matchgroup=mkdDelimiter start="^\s*#####"                              end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
      syn region htmlH6              matchgroup=mkdDelimiter start="^\s*######"                             end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar

      " Lists
      syn match  mkdListItem                                 "^\s*[-*+]\s\+"                                                                       contains=mkdListTab,mkdListBullet2
      syn match  mkdListItem                                 "^\s*\d\+\.\s\+"                                                                      contains=mkdListTab
      syn match  mkdListTab                                  "^\s*\*"                                                                              contained contains=mkdListBullet1
      syn match  mkdListBullet1                              "\*"                                                                                  contained conceal cchar=•
      syn match  mkdListBullet2                              "[-*+]"                                                                               contained conceal cchar=•
      syn region mkdNonListItemBlock                         start="\n\(\_^\_$\|\s\{4,}[^ ]\|\t+[^\t]\)\@!" end="^\(\s*\([-*+]\|\d\+\.\)\s\+\)\@=" contains=@mkdNonListItem,@Spell

      syn match  mkdEscape                                   "\\[`\*_{}\[\]()#\+-\.\!]"                                                            contained contains=mkdEscapeChar
      syn match  mkdEscapeChar                               "\\"                                                                                  contained conceal

      syn cluster mkdNonListItem contains=mkdListItem,mkdEscape,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6
    ]]
  end,
  group = sytax_highlight_group,
  desc = "Highlight word under cursor",
})
-- }}}
