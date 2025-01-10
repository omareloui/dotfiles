local function get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

return {
  "stevearc/oil.nvim",
  event = { "VeryLazy", "BufReadPost", "BufWritePost", "BufNewFile", "BufReadPre" },

  init = function()
    -- Disable netrw in favor of Oil.nivm
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrw = 1
  end,

  config = function()
    local ok, oil = pcall(require, "oil")

    -- stylua: ignore
    if not ok then return end

    _G.get_oil_winbar = get_oil_winbar

    local show_detail = false

    local columns = { "icon" }

    oil.setup {
      default_file_explorer = true,
      keymaps = {
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            show_detail = not show_detail
            if show_detail then
              oil.set_columns { "icon", "permissions", "size", "mtime" }
            else
              oil.set_columns(columns)
            end
          end,
        },
      },
      columns = columns,
      skip_confirm_for_simple_edits = false,
      win_options = {
        winbar = "%!v:lua.get_oil_winbar()",
      },
    }
  end,

  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<Cmd>Oil<CR>", { desc = "Open parent directory" } },
  },
}
