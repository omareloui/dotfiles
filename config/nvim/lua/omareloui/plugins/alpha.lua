M = { "goolord/alpha-nvim" }

M.config = function()
  local present, alpha = pcall(require, "alpha")

  if not present then
    return
  end

  local dashboard = require "alpha.themes.dashboard"

  dashboard.section.header.val = require("omareloui.ui.dashboard").sleekraken

  dashboard.section.buttons.val = {
    dashboard.button("s", "   Last Session", "<Cmd>RestoreSession<CR>"),
    dashboard.button("r", "   Open Repository", "<Cmd>Telescope file_browser cwd=~/repos<CR>"),
    dashboard.button("f", "   Find File", "<Cmd>Telescope find_files<CR>"),
    dashboard.button("c", "   Recent File", "<Cmd>Telescope oldfiles<CR>"),
    dashboard.button("w", "   Find Word", "<Cmd>Telescope live_grep<CR>"),
    dashboard.button("b", "   Bookmarks", "<Cmd>Telescope marks<CR>"),
    dashboard.button("e", "   Settings", "<Cmd>e $MYVIMRC | :cd %:p:h <CR>"),
  }

  local function footer()
    return "omareloui"
  end

  dashboard.section.footer.val = footer()

  dashboard.opts.opts.noautocmd = true

  alpha.setup(dashboard.opts)
end

return M
