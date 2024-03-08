{pkgs, ...}: let
  extraPackages = with pkgs; [
    alejandra
    bazel-buildtools
    buf
    buf-language-server
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
    lua-language-server
    luajitPackages.luacheck
    markdownlint-cli
    marksman
    nil
    nodePackages."@astrojs/language-server"
    nodePackages."@prisma/language-server"
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
