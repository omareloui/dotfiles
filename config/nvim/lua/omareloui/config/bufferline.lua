local present, bufferline = pcall(require, "bufferline")

if not present then
  return
end

vim.opt.termguicolors = true
bufferline.setup {
  options = {
    mode = "tabs",
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,
  },
}
