M = {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
}

M.config = function()
  local present, mason = pcall(require, "mason")

  if not present then
    return
  end

  vim.api.nvim_create_augroup("_mason", { clear = true })
  vim.api.nvim_create_autocmd("Filetype", {
    pattern = "mason",
    callback = function()
      -- TODO:
      -- require("base46").load_highlight "mason"
    end,
    group = "_mason",
  })

  local options = {
    PATH = "skip",

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

  local ensure_installed = {
    "lua-language-server",
    "html-lsp",
    "astro-language-server",
    "css-lsp",
    "deno",
    "eslint-lsp",
    "eslint_d",
    "lua-language-server",
    "luacheck",
    "luaformatter",
    "luau-lsp",
    "markdownlint",
    "prettier",
    "stylua",
    "tailwindcss-language-server",
    "typescript-language-server",
    "vue-language-server",
  }

  vim.api.nvim_create_user_command("MasonInstallAll", function()
    vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
  end, {})

  mason.setup(options)

end

return M