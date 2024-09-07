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
    luaPackages.luacheck
    markdownlint-cli
    marksman
    nil
    nodePackages."@astrojs/language-server"
    nodePackages."@prisma/language-server"
    nodePackages.bash-language-server
    nodePackages.cspell
    nodePackages.sql-formatter
    nodePackages.typescript-language-server
    nodePackages_latest.eslint
    nodePackages_latest.prettier
    prettierd
    pyright
    python312Packages.isort
    python312Packages.black
    python312Packages.flake8
    shellcheck
    shfmt
    sqlfluff
    statix
    stylua
    tailwindcss-language-server
    vale
    vscode-extensions.sonarsource.sonarlint-vscode
    vscode-extensions.vue.volar
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
