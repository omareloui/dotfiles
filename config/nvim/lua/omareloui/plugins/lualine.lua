M = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
}

function M.config()
  local present, lualine = pcall(require, "lualine")

  if not present then
    return
  end

  local c = require "omareloui.ui.palette"
  local i = require "omareloui.ui.icons"
  local i_lualine = i.lualine

  local mode_color = {
    n = c.green,
    i = c.blue,
    v = c.violet,
    [""] = c.violet,
    V = c.violet,
    c = c.yellow,
    no = c.green,
    s = c.orange,
    S = c.orange,
    [""] = c.orange,
    ic = c.yellow,
    R = c.violet,
    Rv = c.violet,
    cv = c.red,
    ce = c.red,
    r = c.cyan,
    rm = c.cyan,
    ["r?"] = c.cyan,
    ["!"] = c.red,
    t = c.red,
  }

  local sep = i.separator.round

  local conditions = {
    has_lsp_client = function()
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        return false
      else
        return true
      end
    end,
  }

  local lsp_progess = function()
    local msg = "LS Inactive"
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
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
      language_servers = language_servers .. "%#SLCopilot#" .. i_lualine.copilot
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
        {
          -- function()
          --   return i_lualine.vim_icon
          -- end,
          "mode",
          -- color = function()
          --   return { bg = mode_color[vim.fn.mode()] }
          -- end,
          separator = { right = sep.right },
        },
        -- {
        --   "mode",
        --   color = function()
        --     return { bg = mode_color[vim.fn.mode()] }
        --   end,
        --   separator = { right = sep.right },
        -- },
      },

      lualine_b = {
        {
          "branch",
          icon = "",
          color = { bg = c.surface0, fg = c.purple },
          separator = { right = sep.right },
        },
        {
          "diff",
          colored = true,
          symbols = i_lualine.diff,
          color = { bg = c.surface0 },
          separator = { left = sep.left, right = sep.right },
        },
      },

      lualine_c = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          sections = { "info", "error", "warn", "hint" },
          symbols = {
            info = i.diagnostics.Info,
            error = i.diagnostics.Error,
            warn = i.diagnostics.Warn,
            hint = i.diagnostics.Hint,
          },
          colored = true,
          always_visible = false,
        },
      },

      lualine_x = {
        {
          lsp_progess,
          color = { bg = c.surface0 },
          separator = { left = sep.left },
          cond = conditions.has_lsp_client,
        },
        {
          function()
            return i_lualine.lsp
          end,
          -- separator = { left = sep.left, right = sep.right },
          separator = { left = sep.left },
          color = { bg = c.purple, fg = c.black },
          cond = conditions.has_lsp_client,
        },
        -- {
        --   "location",
        --   color = { bg = c.surface0 },
        --   separator = { left = sep.left },
        --   cond = function()
        --     return not conditions.has_lsp_client()
        --   end,
        -- },
        -- {
        --   "location",
        --   color = { bg = c.surface0 },
        --   cond = conditions.has_lsp_client,
        -- },
        -- {
        --   function()
        --     return i_lualine.location
        --   end,
        --   color = { bg = c.blue, fg = c.black },
        --   separator = { left = sep.left },
        -- },
      },

      lualine_y = {},

      lualine_z = {
        -- {
        --   function()
        --     return ""
        --   end,
        --   color = { bg = c.crust, fg = c.white },
        -- },
      },
    },
  }
end

return M
