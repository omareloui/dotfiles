return {
  {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    enabled = false,
    dependencies = { "neovim/nvim-lspconfig" },

    opts = {
      filetypes = { "javascript", "typescript" },
      server = {
        settings = {
          sonarlint = {
            rules = {
              -- General JavaScript/TypeScript rules
              ["javascript:S125"] = {
                level = "on", -- Commented out code should be removed
              },
              ["javascript:S1481"] = {
                level = "on", -- Remove unused local variables
              },
              ["javascript:S1523"] = {
                level = "on", -- Functions should not have too many parameters
              },
              ["javascript:S1128"] = {
                level = "on", -- Remove unnecessary imports
              },
              ["javascript:S1066"] = {
                level = "on", -- Merge if statements to reduce complexity
              },
              ["javascript:S3353"] = {
                level = "on", -- Remove unused function parameters
              },
              ["javascript:S2757"] = {
                level = "on", -- For loop stop conditions should be invariant
              },
              ["javascript:S2870"] = {
                level = "on", -- Avoid for loops with always true/unreachable stop conditions
              },
              -- TypeScript specific rules
              ["typescript:S125"] = {
                level = "on", -- Commented out code should be removed
              },
              ["typescript:S1481"] = {
                level = "on", -- Remove unused local variables
              },
              ["typescript:S1523"] = {
                level = "on", -- Functions should not have too many parameters
              },
              ["typescript:S1128"] = {
                level = "on", -- Remove unnecessary imports
              },
              ["typescript:S1066"] = {
                level = "on", -- Merge if statements to reduce complexity
              },
              ["typescript:S3353"] = {
                level = "on", -- Remove unused function parameters
              },
              ["typescript:S2757"] = {
                level = "on", -- For loop stop conditions should be invariant
              },
              ["typescript:S2870"] = {
                level = "on", -- Avoid for loops with always true/unreachable stop conditions
              },
              -- Next.js and React specific rules
              ["react:S6844"] = {
                level = "on", -- Detect issues in React components
              },
              ["react:S6660"] = {
                level = "on", -- Prevent using unsafe lifecycle methods in React
              },
              ["react:S4324"] = {
                level = "on", -- Ensure consistent React component naming
              },
              ["react:S6785"] = {
                level = "on", -- Detect missing key props in lists
              },
            },
          },
        },
      },
    },
  },
}
