local M = {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
}

M.config = function()
  local present, mason = pcall(require, "mason")

  if not present then
    return
  end

  vim.api.nvim_create_augroup("_mason", { clear = true })

  local options = {
    ui = {
      icons = {
        package_pending = " ",
        package_installed = " ",
        package_uninstalled = " ﮊ",
      },

      keymaps = {
        toggle_server_expand = "<CR>",
        install_server = "i",
        update_server = "u",
        check_server_version = "c",
        update_all_servers = "U",
        check_outdated_servers = "C",
        uninstall_server = "X",
        cancel_installation = "<C-c>",
      },
    },

    max_concurrent_installers = 10,
  }

  mason.setup(options)

  require("mason-lspconfig").setup {
    automatic_installation = true,
    ensure_installed = {
      "astro",
      "bashls",
      "cssls",
      "denols",
      "emmet_ls",
      "eslint",
      "html",
      "lua_ls",
      "marksman",
      "prismals",
      "tailwindcss",
      "tsserver",
      "volar",
      "yamlls",
    },
  }
end

return M
