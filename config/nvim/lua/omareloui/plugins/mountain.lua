M = {
  "omareloui/mountain.nvim",
  name = "mountain",
  lazy = false,
  priority = 1001,
}

function M.config()
  local present, mountain = pcall(require, "mountain")

  if not present then
    return
  end

  require "omareloui.config.theme"
end
return M
