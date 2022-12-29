local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local fn = vim.fn

function HighlightWordUnderCursor()
  local disable_ft = { "qf", "fugitive", "nerdtree", "gundo", "diff", "fzf", "floaterm" }
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
autocmd(
  { "CursorHold", "CursorHoldI" },
  { pattern = "*", callback = HighlightWordUnderCursor, group = match_cursor_word_group }
)
