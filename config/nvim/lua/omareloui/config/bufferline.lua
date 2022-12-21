local present, bufferline = pcall(require, "bufferline")

if not present then
  return
end

vim.opt.termguicolors = true
bufferline.setup { options = { mode = "tabs" } }
