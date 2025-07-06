{
  inputs,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
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
      dockerfile-language-server-nodejs
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
      vale
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
        plugins = {
          mason = {
            enabled = false,
          },
        },
        system_packages = {
          vue_lsp = "${pkgs.vue-language-server + "/lib/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"}",
          omnisharp_dll = "${pkgs.omnisharp-roslyn + "/lib/omnisharp-roslyn/OmniSharp.dll"}",
        }
      }
    '';
}
