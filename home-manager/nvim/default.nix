{pkgs, ...}: let
  extraPackages = with pkgs; [
    # astro-language-server
    # buf
    # buf-language-server
    # buildifier
    # elixir-ls
    # nixfmt
    # prisma-language-server
    # templ
    alejandra
    dockerfile-language-server-nodejs
    emmet-ls
    eslint_d
    gitlint
    golangci-lint
    gopls
    hadolint
    htmlhint
    lua-language-server
    luajitPackages.luacheck
    markdownlint-cli
    marksman
    nil
    nodePackages.bash-language-server
    nodePackages.cspell
    nodePackages.prisma
    nodePackages.sql-formatter
    nodePackages.typescript-language-server
    nodePackages.volar
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-json-languageserver-bin
    prettierd
    shellcheck
    shfmt
    shfmt
    sqlfluff
    stylua
    tailwindcss-language-server
    yaml-language-server
    yamlfmt
    yamllint
  ];
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    inherit extraPackages;
  };

  home.file.".config/nvim" = {
    source = ./cfg;
    recursive = true;
  };
}
