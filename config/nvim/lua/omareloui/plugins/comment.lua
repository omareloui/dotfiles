local present, nvim_comment = pcall(require, "Comment")

if not present then
  return
end

local options = {}

nvim_comment.setup(options)
