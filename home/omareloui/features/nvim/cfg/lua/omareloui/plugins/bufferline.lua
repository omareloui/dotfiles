return {
  "akinsho/bufferline.nvim",
  enabled = false,

  config = function()
    local present, bufferline = pcall(require, "bufferline")

    if not present then
      return
    end

    local icons = require("omareloui.config.ui.icons").bufferline
    local opts = {
      options = {
        modified_icon = icons.modified,
        diagnostics = "nvim_lsp",
        component_separators = "|",
        section_separators = "",
        diagnostics_indicator = function(count)
          return " " .. icons.diagnostics .. count
        end,
      },
    }

    bufferline.setup(opts)

    local set = require("omareloui.util.keymap").set
    set("<C-S-Right>", "<Cmd>BufferLineMoveNext<CR>", "Move the tab to the right", { silent = true })
    set("<C-S-Left>", "<Cmd>BufferLineMovePrev<CR>", "Move the tab to the left", { silent = true })
    set("<Tab>", "<Cmd>BufferLineCycleNext<CR>", "Go to next buffer")
    set("<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", "Go to previous buffer")
    set("<leader>bo", function()
      for _, e in ipairs(require("bufferline").get_elements().elements) do
        if e.id ~= vim.api.nvim_get_current_buf() then
          vim.api.nvim_buf_delete(e.id, {})
        end
      end
    end, "Close all other buffers", { silent = true })
    set("<leader>bx", function()
      for _, e in ipairs(require("bufferline").get_elements().elements) do
        vim.api.nvim_buf_delete(e.id, {})
      end
    end, "Close all buffers", { silent = true })
  end,
}
