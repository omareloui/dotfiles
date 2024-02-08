{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # astro-language-server
    # buf
    # buf-language-server
    # buildifier
    # elixir-ls
    # prisma-language-server
    # templ

    loupe
    gnome.gnome-bluetooth
    font-manager
    variety
    entr

    acpi
    autoconf
    automake
    bat
    bison
    bottom
    brillo
    cargo
    corepack_latest
    dconf
    deno
    docker
    dockerfile-language-server-nodejs
    du-dust
    dunst
    emmet-ls
    eslint_d
    eza
    fd
    flex
    font-awesome
    fontforge
    fzf
    gcc
    git
    gitlint
    gnumake
    go
    golangci-lint
    gopls
    gparted
    hadolint
    htmlhint
    jq
    keepassxc
    kitty
    lazygit
    lf
    libcanberra-gtk3
    libiconv
    libnotify
    libtool
    lua
    lua-language-server
    luajitPackages.luacheck
    luarocks
    makeWrapper
    markdownlint-cli
    marksman
    microsoft-edge
    neofetch
    networkmanagerapplet
    nil
    nixfmt
    nodePackages.bash-language-server
    nodePackages.cspell
    nodePackages.prisma
    nodePackages.sql-formatter
    nodePackages.typescript-language-server
    nodePackages.volar
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-json-languageserver-bin
    nodejs
    patchelf
    pkg-config
    polkit_gnome
    prettierd
    ripgrep
    rofi-wayland
    rustup
    shellcheck
    shfmt
    sqlfluff
    starship
    stylua
    swww
    tailwindcss-language-server
    telegram-desktop
    tldr
    tree
    unzip
    vlc
    wget
    wl-clipboard
    xfce.thunar
    yaml-language-server
    yamlfmt
    yamllint
    # yazi
    zoxide
    atuin
    # stable.atuin
  ];
}
