M = { "mickael-menu/zk-nvim" }

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
