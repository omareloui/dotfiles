local session_group = vim.api.nvim_create_augroup("Session", {clear = true})

vim.api.nvim_create_autocmd("VimEnter", {
  command = "silent! RestoreSession",
  group = session_group
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  command = "silent! SaveSession",
  group = session_group
})

