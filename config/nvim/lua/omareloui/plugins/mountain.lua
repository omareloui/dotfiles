M = {
  "omareloui/mountain.nvim",
  name = "mountain",
  lazy = false,
  priority = 1000,
}

function M.config()
  local present, mountain = pcall(require, "mountain")

  if not present then
    return
  end

  pcall(require, "omareloui.config.theme")
end
return M
