local ok, gitsigns = pcall(require, "nvim_comment")

if not ok then return end

gitsigns.setup {
  line_mapping = "<leader>cl",
  operator_mapping = "<leader>c",
  comment_chunk_text_object = "ic"
}
