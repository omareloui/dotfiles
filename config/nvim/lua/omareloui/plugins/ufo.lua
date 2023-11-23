local function virtual_text_handler(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("  %d "):format(endLnum - lnum)
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
      -- str width returned from truncate() may less than 2nd argument, need padding
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

  config = function()
    local ok, ufo = pcall(require, "ufo")

    -- stylua: ignore
    if not ok then return end

    local opts = {
      provider_selector = function()
        return { "lsp", "indent" }
      end,
      close_fold_kinds = { "imports", "comment" },
      open_fold_hl_timeout = 40,
      fold_virt_text_handler = virtual_text_handler,
    }

    local set = require("omareloui.util.keymap").set
    set("zM", require("ufo").closeAllFolds, "Close all folds")
    set("zR", require("ufo").openAllFolds, "Open all folds")

    require("omareloui.config.ui.highlights").ufo()

    ufo.setup(opts)
  end,
}
