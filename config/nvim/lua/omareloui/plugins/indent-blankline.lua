M = { "lukas-reineke/indent-blankline.nvim" }

M.config = function()
  local present, blankline = pcall(require, "indent_blankline")

  if not present then
    return
  end

  -- TODO:
  -- require("base46").load_highlight "blankline"

  local options = {
    indentLine_enabled = 1,
    filetype_exclude = {
      "help",
      "terminal",
      "alpha",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "mason",
    },
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    show_current_context = true,
    show_current_context_start = true,
  }

  blankline.setup(options)
end

return M
