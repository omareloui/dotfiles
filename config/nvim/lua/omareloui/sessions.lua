local session_group = vim.api.nvim_create_augroup("Session", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  command = [[
    if !exists("g:vscode")
      silent! RestoreSession
    endif
  ]],
  group = session_group
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  command = [[
    if !exists("g:vscode")
      silent! SaveSession
    endif
  ]],
  group = session_group
})
