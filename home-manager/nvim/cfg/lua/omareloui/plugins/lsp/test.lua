return {
  "nvim-neotest/neotest",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    "nvim-neotest/neotest-go",
    "haydenmeade/neotest-jest",
    "marilari88/neotest-vitest",
    "nvim-lua/plenary.nvim",
  },
    -- stylua: ignore
  keys = {
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
    { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
  },

  config = function()
    local ok, neotest = pcall(require, "neotest")

    -- stylua: ignore
    if not ok then return end

    local wk = require "which-key"
    wk.add { { "<leader>t", group = "test" } }

    local neotest_jest = require "neotest-jest"
    local neotest_vitest = require "neotest-vitest"
    local neotest_go = require "neotest-go"

    local opts = {
      adapters = {
        neotest_jest {
          jestCommand = "jest --watch ",
        },
        neotest_vitest,
        neotest_go,
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          require("trouble").open { mode = "quickfix", focus = false }
        end,
      },
    }

    neotest.setup(opts)
  end,
}
