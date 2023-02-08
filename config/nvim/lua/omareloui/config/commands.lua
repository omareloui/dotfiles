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

-- Execute sh files and preview the result {{{
vim.cmd "command Exec set splitright | vnew | set filetype=sh | read !sh #"
-- }}}
