local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

function HighlightWordUnderCursor()
  local disable_ft = { "qf", "fugitive", "nerdtree", "gundo", "diff", "fzf", "floaterm" }
  local curr_ft = vim.api.nvim_buf_get_option(0, "filetype")

  -- TODO: Make this a lua check
  -- let disabled_ft = ["qf", "fugitive", "nerdtree", "gundo", "diff", "fzf", "floaterm"]
  -- if &diff || &buftype == "terminal" || index(disabled_ft, &filetype) >= 0
  --   return
  -- endif

  for _, ft in ipairs(disable_ft) do
    if ft == curr_ft then
      return
    end
  end

  local cword = vim.fn.escape(vim.fn.expand "<cword>", "/\\")
  vim.fn.execute("match CursorMatchWord /\\V\\<" .. cword .. "\\>/")
end

local match_cursor_word_group = augroup("MatchCursorWord", { clear = true })
autocmd(
  { "CursorHold", "CursorHoldI" },
  { pattern = "*", callback = HighlightWordUnderCursor, group = match_cursor_word_group }
)
