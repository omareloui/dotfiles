M = {
  "glacambre/firenvim",
  build = function()
    vim.fn["firenvim#install"](0)
  end,
}

vim.g.firenvim_config = {
  localSettings = {
    [".*"] = {
      cmdline = "firenvim",
      priority = 0,
      selector = 'textarea:not([readonly]):not([class="handsontableInput"]), div[role="textbox"]',
      takeover = "always",
    },
    [".*notion\\.so.*"] = {
      priority = 9,
      takeover = "never",
    },
    [".*docs\\.google\\.com.*"] = {
      priority = 9,
      takeover = "never",
    },
  },
}

return M
