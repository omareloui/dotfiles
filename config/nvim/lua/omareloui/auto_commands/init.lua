------------------------------ reopen closed tabs ------------------------------
vim.cmd [[
  " idea to make it better: make that reopen buf a list and on each restore
  " remove the top of that list.

  let g:reopenbuf = expand('%:p')

  function! ReopenLastTabLeave()
    let g:lastbuf = expand('%:p')
    let g:lasttabcount = tabpagenr('$')
  endfunction

  function! ReopenLastTabEnter()
    if tabpagenr('$') < g:lasttabcount
      let g:reopenbuf = g:lastbuf
    endif
  endfunction

  function! ReopenLastTab()
    tabnew
    execute 'buffer' . g:reopenbuf
  endfunction

  augroup ReopenLastTab
    autocmd!
    autocmd TabLeave * call ReopenLastTabLeave()
    autocmd TabEnter * call ReopenLastTabEnter()
  augroup END

  " Tab Restore
  nnoremap <leader>tr :call ReopenLastTab()<CR>
]]

---------------------------------- nvim tree ----------------------------------
-- close nvim tree on all tabs
-- source: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
-- This will:
-- Close the tab if nvim-tree is the last buffer in the tab (after closing a buffer)
-- Close vim if nvim-tree is the last buffer (after closing a buffer)
-- Close nvim-tree across all tabs when one nvim-tree buffer is manually closed if and only if tabs.sync.close is set.
local function tab_win_closed(winnr)
  local api = require "nvim-tree.api"
  local tabnr = vim.api.nvim_win_get_tabpage(winnr)
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  local buf_info = vim.fn.getbufinfo(bufnr)[1]
  local tab_wins = vim.tbl_filter(function(w)
    return w ~= winnr
  end, vim.api.nvim_tabpage_list_wins(tabnr))
  local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
  if buf_info.name:match ".*NvimTree_%d*$" then -- close buffer was nvim tree
    -- Close all nvim tree on :q
    if not vim.tbl_isempty(tab_bufs) then -- and was not the last window (not closed automatically by code below)
      api.tree.close()
    end
  else -- else closed buffer was normal buffer
    if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
      local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
      if last_buf_info.name:match ".*NvimTree_%d*$" then -- and that buffer is nvim tree
        vim.schedule(function()
          if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
            vim.cmd "quit" -- then close all of vim
          else -- else there are more tabs open
            vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
          end
        end)
      end
    end
  end
end

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function()
    local winnr = tonumber(vim.fn.expand "<amatch>")
    vim.schedule_wrap(tab_win_closed(winnr))
  end,
  nested = true,
})
