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
      " don't use standard HiLink, it will not work with included syntax files
      if version < 508|command! -nargs=+ HtmlHiLink hi link <args>|else|command! -nargs=+ HtmlHiLink hi def link <args>|endif
          command! -nargs=+ HtmlHiLink hi link <args>
      else|command! -nargs=+ HtmlHiLink hi def link <args>|endif
          command! -nargs=+ HtmlHiLink hi def link <args>
      endif


      syn spell toplevel
      syn case ignore
      syn sync linebreaks=1

      "additions to HTML groups
      syn region htmlItalic          matchgroup=mkdDelimiter start="\\\@<!\*\S\@="                          end="\S\@<=\\\@<!\*"                   keepend oneline concealends contains=mkdEscape
      syn region htmlItalic          matchgroup=mkdDelimiter start="\(^\|\s\)\@<=_\|\\\@<!_\([^_]\+\s\)\@=" end="\S\@<=_\|_\S\@="                  keepend oneline concealends contains=mkdEscape
      syn region htmlBold            matchgroup=mkdDelimiter start="\S\@<=\*\*\|\*\*\S\@="                  end="\S\@<=\*\*\|\*\*\S\@="            keepend oneline concealends contains=mkdEscape
      syn region htmlBold            matchgroup=mkdDelimiter start="\S\@<=__\|__\S\@="                      end="\S\@<=__\|__\S\@="                keepend oneline concealends contains=mkdEscape
      syn region htmlBoldItalic      matchgroup=mkdDelimiter start="\S\@<=\*\*\*\|\*\*\*\S\@="              end="\S\@<=\*\*\*\|\*\*\*\S\@="        keepend oneline concealends contains=mkdEscape
      syn region htmlBoldItalic      matchgroup=mkdDelimiter start="\S\@<=___\|___\S\@="                    end="\S\@<=___\|___\S\@="              keepend oneline concealends contains=mkdEscape
      syn region mkdFootnotes        matchgroup=mkdDelimiter start="\[^"                                    end="\]"
      syn region mkdID               matchgroup=mkdDelimiter start="\!?\["                                  end="\]"                               contained oneline
      syn region mkdURL              matchgroup=mkdDelimiter start="("                                      end=")"                                contained contains=mkdEscape,mkdURLInnerParen oneline
      syn match  mkdURLInnerParen                            "([^)]*)"                                                                             contained
      syn region mkdLink             matchgroup=mkdDelimiter start="\\\@<!\["                               end="\]\ze\s*[[(]"                     contains=@Spell,mkdEscape nextgroup=mkdURL,mkdID skipwhite oneline concealends cchar=→
      syn match  mkdInlineURL                                /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/
      syn region mkdLinkDef          matchgroup=mkdDelimiter start="^ \{,3}\zs\["                           end="]:"                               oneline nextgroup=mkdLinkDefTarget skipwhite
      syn region mkdLinkDefTarget                            start="<\?\zs\S" excludenl                     end="\ze[>[:space:]\n]"                contained nextgroup=mkdLinkTitle,mkdLinkDef skipwhite skipnl oneline
      syn region mkdLinkTitle        matchgroup=mkdDelimiter start=+"+                                      end=+"+                                contained
      syn region mkdLinkTitle        matchgroup=mkdDelimiter start=+'+                                      end=+'+                                contained
      syn region mkdLinkTitle        matchgroup=mkdDelimiter start=+(+                                      end=+)+                                contained

      "define Markdown groups
      syn match  mkdLineContinue                             ".$"                                                                                  contained
      syn match  mkdLineBreak                                /  \+$/
      syn region mkdBlockquote                               start=/^\s*>/                                  end=/$/                                contains=mkdLineBreak,mkdLineContinue,@Spell
      syn region mkdCode             matchgroup=mkdDelimiter start=/\(\([^\\]\|^\)\\\)\@<!`/                end=/\(\([^\\]\|^\)\\\)\@<!`/          concealends
      syn region mkdCode             matchgroup=mkdDelimiter start=/\s*``[^`]*/                             end=/[^`]*``\s*/                       concealends
      syn region mkdCode             matchgroup=mkdDelimiter start=/^\s*```.*$/                             end=/^\s*```\s*$/                      concealends contains=mkdCodeCfg
      syn match  mkdCodeCfg                                  "{[^}]*}"                                                                             contained conceal
      syn region mkdCode             matchgroup=mkdDelimiter start="<pre[^>\\]*>"                           end="</pre>"                           concealends
      syn region mkdCode             matchgroup=mkdDelimiter start="<code[^>\\]*>"                          end="</code>"                          concealends
      syn region mkdFootnote         matchgroup=mkdDelimiter start="\[^"                                    end="\]"
      syn match  mkdCode                                     /^\s*\n\(\(\s\{8,}[^ ]\|\t\t\+[^\t]\).*\n\)\+/
      syn match  mkdIndentCode                               /^\s*\n\(\(\s\{4,}[^ ]\|\t\+[^\t]\).*\n\)\+/                                          contained
      syn match  mkdListItem                                 "^\s*[-*+]\s\+"                                                                       contains=mkdListTab,mkdListBullet2
      syn match  mkdListItem                                 "^\s*\d\+\.\s\+"                                                                      contains=mkdListTab
      syn match  mkdListTab                                  "^\s*\*"                                                                              contained contains=mkdListBullet1
      syn match  mkdListBullet1                              "\*"                                                                                  contained conceal cchar=•
      syn match  mkdListBullet2                              "[-*+]"                                                                               contained conceal cchar=•
      syn region mkdNonListItemBlock                         start="\n\(\_^\_$\|\s\{4,}[^ ]\|\t+[^\t]\)\@!" end="^\(\s*\([-*+]\|\d\+\.\)\s\+\)\@=" contains=@mkdNonListItem,@Spell
      syn match  mkdRule                                     /^\s*\*\s\{0,1}\*\s\{0,1}\*$/
      syn match  mkdRule                                     /^\s*-\s\{0,1}-\s\{0,1}-$/
      syn match  mkdRule                                     /^\s*_\s\{0,1}_\s\{0,1}_$/
      syn match  mkdRule                                     /^\s*-\{3,}$/
      syn match  mkdRule                                     /^\s*\*\{3,5}$/

      " HTML headings
      syn region htmlH1              matchgroup=mkdDelimiter start="^\s*#"                                  end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
      syn region htmlH2              matchgroup=mkdDelimiter start="^\s*##"                                 end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
      syn region htmlH3              matchgroup=mkdDelimiter start="^\s*###"                                end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
      syn region htmlH4              matchgroup=mkdDelimiter start="^\s*####"                               end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
      syn region htmlH5              matchgroup=mkdDelimiter start="^\s*#####"                              end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
      syn region htmlH6              matchgroup=mkdDelimiter start="^\s*######"                             end="\($\|[^\\]#\+\)"                  concealends contains=@Spell,mkdEscapeChar
      syn match  htmlH1                                      /^.\+\n=\+$/                                                                          contains=@Spell
      syn match  htmlH2                                      /^.\+\n-\+$/                                                                          contains=@Spell
      syn match  mkdEscape                                   "\\[`\*_{}\[\]()#\+-\.\!]"                                                            contained contains=mkdEscapeChar
      syn match  mkdEscapeChar                               "\\"                                                                                  contained conceal

      syn cluster mkdNonListItem contains=htmlItalic,htmlBold,htmlBoldItalic,mkdFootnotes,mkdID,mkdLink,mkdLinkDef,mkdLineBreak,mkdBlockquote,mkdCode,mkdIndentCode,mkdListItem,mkdRule,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6,mkdEscape

      " Highlighting for Markdown groups
      HtmlHiLink mkdString        String
      HtmlHiLink mkdCode          String
      HtmlHiLink mkdIndentCode    String
      HtmlHiLink mkdEscape        Comment
      HtmlHiLink mkdEscapeChar    Comment
      HtmlHiLink mkdFootnote      Comment
      HtmlHiLink mkdBlockquote    Comment
      HtmlHiLink mkdLineContinue  Comment
      HtmlHiLink mkdDelimiter     Comment
      HtmlHiLink mkdListItem      Identifier
      HtmlHiLink mkdRule          Identifier
      HtmlHiLink mkdLineBreak     Todo
      HtmlHiLink mkdFootnotes     htmlLink
      HtmlHiLink mkdLink          htmlLink
      HtmlHiLink mkdURL           htmlString
      HtmlHiLink mkdURLInnerParen mkdURL
      HtmlHiLink mkdInlineURL     htmlLink
      HtmlHiLink mkdID            Identifier
      HtmlHiLink mkdLinkDef       mkdID
      HtmlHiLink mkdLinkDefTarget mkdURL
      HtmlHiLink mkdLinkTitle     htmlString
      HtmlHiLink mkdDelimiter     Delimiter

      setlocal formatoptions+=r "Automatically insert bullets
      setlocal formatoptions-=c "Do not automatically insert bullets when auto-wrapping with text-width
      setlocal comments=b:*,b:+,b:- "Accept various markers as bullets
      let b:current_syntax = "mkdc"
      delcommand HtmlHiLink
    ]]
  end,
  group = sytax_highlight_group,
  desc = "Highlight word under cursor",
})
-- }}}
