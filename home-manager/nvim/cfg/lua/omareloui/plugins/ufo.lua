local function virtual_text_handler(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰁂 %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },

  -- stylua: ignore
  keys = {
    { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
    { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
    { "zK", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek folds" },
  },

  config = function()
    local ok, ufo = pcall(require, "ufo")

    -- stylua: ignore
    if not ok then return end

    local opts = {
      provider_selector = function()
        return { "lsp", "indent" }
      end,
      open_fold_hl_timeout = 60,
      close_fold_kinds_for_ft = {
        -- default = { "imports", "comment" },
        json = { "array" },
      },
      fold_virt_text_handler = virtual_text_handler,
    }

    ufo.setup(opts)

    -- Highlights
    local c = require "omareloui.config.ui.palette"
    vim.api.nvim_set_hl(0, "Folded", { fg = c.subtext1, bg = c.crust, blend = 50 })
  end,
}
