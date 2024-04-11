{pkgs, ...}: let
  extraPackages = with pkgs; [
    alejandra
    bazel-buildtools
    buf
    buf-language-server
    codeium
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
    prettierd
    shellcheck
    shfmt
    sqlfluff
    statix
    stylua
    tailwindcss-language-server
    vscode-langservers-extracted
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
