local present, gitsigns = pcall(require, "gitsigns")

if not present then
  return
end

-- TODO:
-- require("base46").load_highlight "git"

local options = {
  signs = {
    add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
    change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
    delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
    topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
    changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
  },
  on_attach = function(bufnr)
    -- TODO:
    -- utils.load_mappings("gitsigns", { buffer = bufnr })
  end
}

gitsigns.setup(options)
