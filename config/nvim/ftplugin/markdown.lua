local path = vim.fn.expand "%:p:h"
local in_zk_dir = string.find(path, vim.fn.expand "$ZK_NOTEBOOK_DIR")

if not in_zk_dir then
  return
end

require("omareloui.config.mappings").zk()
