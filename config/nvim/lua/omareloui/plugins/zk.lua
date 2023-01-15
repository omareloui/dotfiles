M = { "mickael-menu/zk-nvim", init = require("omareloui.config.mappings").zk() }

function M.config()
  local present, zk = pcall(require, "zk")

  if not present then
    return
  end

  zk.setup {
    picker = "telescope",
  }
end

return M
