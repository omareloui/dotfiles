{
  inputs,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly.packages.${pkgs.stdenv.hostPlatform.system}.default;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      alejandra
      angular-language-server
      ansible-lint
      bazel-buildtools
      buf
      codeium
      csharpier
      dockerfile-language-server
      elixir-ls
      emmet-ls
      eslint_d
      gitlint
      golangci-lint
      gomodifytags
      gopls
      gotest
      hadolint
      htmlhint
      iferr
      impl
      jinja-lsp
      libclang
      lua-language-server
      luaPackages.luacheck
      markdownlint-cli
      marksman
      nil
      nodePackages."@astrojs/language-server"
      nodePackages.bash-language-server
      nodePackages.cspell
      nodePackages.sql-formatter
      nodePackages.typescript-language-server
      nodePackages_latest.eslint
      nodePackages_latest.prettier
      omnisharp-roslyn
      prettierd
      pyright
      python312Packages.black
      python312Packages.flake8
      python312Packages.isort
      shellcheck
      shfmt
      sqlfluff
      sqls
      statix
      stylua
      tailwindcss-language-server
      vscode-extensions.sonarsource.sonarlint-vscode
      vscode-extensions.vue.volar
      vscode-langservers-extracted
      vue-language-server
      yaml-language-server
      yamlfmt
      yamllint
    ];
  };

  home.file.".config/nvim".source = inputs.nvim-config;

  home.file.".config/nvim-local/localconfig.lua".text =
    /*
    lua
    */
    ''
      return {
        lsp = {
          servers = {
            angularls = {},
            astro = {},
            bashls = {},
            buf_ls = {},
            clangd = {},
            cssls = {},
            docker_compose_language_service = {},
            dockerls = {},
            emmet_ls = {
             filetypes = {
               "html",
               "typescriptreact",
               "javascriptreact",
               "handlebars",
               "css",
               "sass",
               "scss",
               "less",
               "vue",
               "astro",
             },
             init_options = {
               html = {
                 options = {
                   -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                   ["bem.enabled"] = true,
                 },
               },
             },
           },
           gopls = {
             filetypes = { "go", "gomod" },
             settings = {
               gopls = {
                 completeUnimported = true,
                 usePlaceholders = true,
                 analyses = {
                   unusedparams = true,
                 },
                 staticcheck = true,
                 gofumpt = true,
               },
             },
           },
           html = {},
            jinja_lsp = {},
            jsonls = {},
            lua_ls = {},
            marksman = {},
            nil_ls = {},
            omnisharp = {},
            prismals = {},
            pylsp = {},
            sqls = {},
            tailwindcss = {},
            templ = {},
            ts_ls = {},
            vue_ls = {},
            yamlls = {},
          },

          formatters_by_ft = {
            angular = { "prettierd" },
            astro = { "prettierd" },
            bzl = { "buildifier" },
            cs = { "csharpier" },
            css = { "prettierd" },
            graphql = { "prettierd" },
            html = { "prettierd" },
            htmlangular = { "prettierd" },
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            json = { "prettierd" },
            jsonc = { "prettierd" },
            lua = { "stylua" },
            markdown = { "prettierd" },
            nix = { "alejandra" },
            proto = { "buf" },
            python = { "isort", "black" },
            sh = { "shfmt" },
            sql = { "sqlfluff" },
            svelte = { "prettierd" },
            svg = { "prettier" },
            templ = { "templ" },
            toml = { "prettierd" },
            typescript = { "prettierd" },
            typescriptreact = { "prettierd" },
            vue = { "prettierd" },
            yaml = { "prettierd" },
          },

          linters_by_ft = {
            astro = { "eslint", "cspell" },
            bzl = { "buildifier", "cspell" },
            cs = { "cspell" },
            dockerfile = { "hadolint", "cspell" },
            gitcommit = { "gitlint", "cspell" },
            go = { "golangcilint", "cspell" },
            html = { "htmlhint", "cspell" },
            javascript = { "eslint", "cspell" },
            javascriptreact = { "eslint", "cspell" },
            lua = { "luacheck", "cspell" },
            markdown = { "markdownlint", "cspell" },
            nix = { "statix", "cspell" },
            proto = { "buf", "cspell" },
            python = { "flake8" },
            sh = { "shellcheck", "cspell" },
            sql = { "sqlfluff", "cspell" },
            svelte = { "eslint", "cspell" },
            text = { "cspell" },
            typescript = { "eslint", "cspell" },
            typescriptreact = { "eslint", "cspell" },
            yaml = { "yamllint", "cspell" },
            ansible = { "ansible_lint" },
            vue = { "eslint", "cspell" },
          },

          mason = {
            enabled = false,
          },
        },
      }
    '';
}
