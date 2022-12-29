M = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
}

M.config = function()
  local present, lualine = pcall(require, "lualine")

  if not present then
    return
  end

  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = {
      "info",
      "error",
      "warn",
      "hint",
    },
    symbols = {
      error = " ",
      warn = " ",
      hint = " ",
      info = " ",
    },
    colored = true,
    always_visible = false,
  }

  local diff = {
    "diff",
    colored = true,
    symbols = {
      added = " ",
      modified = " ",
      removed = " ",
    },
    color = { bg = "#242735" },
    separator = { left = "", right = "" },
  }

  local vim_icons = {
    function()
      return ""
    end,
  }

  local modes = {
    "mode",
    separator = { left = "", right = "" },
  }

  local branch = {
    "branch",
    icon = "",
    color = { bg = "#242735", fg = "#c296eb" },
    separator = { left = "", right = "" },
  }

  local lsp_progess = function()
    local msg = "LS Inactive"
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
      -- TODO: clean up this if statement
      if type(msg) == "boolean" or #msg == 0 then
        return "LS Inactive"
      end
      return msg
    end
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}
    local copilot_active = false
    local null_ls = require "null-ls"
    local alternative_methods = {
      null_ls.methods.DIAGNOSTICS,
      null_ls.methods.DIAGNOSTICS_ON_OPEN,
      null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }

    -- add client
    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" and client.name ~= "copilot" then
        table.insert(buf_client_names, client.name)
      end

      if client.name == "copilot" then
        copilot_active = true
      end
    end

    local function list_registered_providers_names(filetype)
      local s = require "null-ls.sources"
      local available_sources = s.get_available(filetype)
      local registered = {}
      for _, source in ipairs(available_sources) do
        for method in pairs(source.methods) do
          registered[method] = registered[method] or {}
          table.insert(registered[method], source.name)
        end
      end
      return registered
    end

    local function list_registered(filetype)
      local registered_providers = list_registered_providers_names(filetype)
      local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
        return registered_providers[m] or {}
      end, alternative_methods))
      return providers_for_methods
    end

    local function formatters_list_registered(filetype)
      local registered_providers = list_registered_providers_names(filetype)
      return registered_providers[null_ls.methods.FORMATTING] or {}
    end
    -- formatters
    local supported_formatters = formatters_list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_formatters)

    -- linters
    local supported_linters = list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_linters)
    local unique_client_names = vim.fn.uniq(buf_client_names)

    local language_servers = "" .. table.concat(unique_client_names, ", ") .. ""

    if copilot_active then
      language_servers = language_servers .. "%#SLCopilot#" .. ""
    end

    return language_servers
  end

  lualine.setup {
    options = {
      theme = "catppuccin",
      globalstatus = true,
      icons_enabled = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha", "dashboard" },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = {
        vim_icons,
        modes,
      },
      lualine_b = {},
      lualine_c = {
        { "filetype", icon_only = true, colored = true },
        { "filename" },
        branch,
        diff,
        {
          function()
            return ""
          end,
          color = { bg = "#8FCDA9", fg = "#121319" },
          separator = { left = "", right = "" },
        },
        diagnostics,
      },
      lualine_x = {
        "encoding",
        lsp_progess,
        {
          function()
            return ""
          end,
          separator = { left = "", right = "" },
          color = { bg = "#C296EB", fg = "#000000" },
        },
        "progress",
        {
          function()
            return ""
          end,
          separator = { left = "", right = "" },
          color = { bg = "#ECD3A0", fg = "#000000" },
        },
        { "location" },
        {
          function()
            return ""
          end,
          separator = { left = "" },
          color = { bg = "#86AAEC", fg = "#000000" },
        },
      },
      lualine_y = {},
      lualine_z = {},
    },
  }
end

return M
