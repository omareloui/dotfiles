{pkgs, ...}: {
  home.packages = with pkgs; [
    #

    acpi
    age
    ark
    autoconf
    bat
    bc
    bison
    bottom
    brillo
    btrfs-progs
    calibre
    cliphist
    cloc
    codeium
    corepack_latest
    dconf
    du-dust
    entr
    eva
    fd
    ffmpeg
    file
    firefox
    flex
    font-awesome
    font-manager
    fontforge
    fzf
    gcc
    gh
    ghostscript
    git
    gnome-bluetooth
    gnome-disk-utility
    hyprpicker
    imagemagick
    jq
    keepassxc
    kora-icon-theme
    libcanberra-gtk3
    libiconv
    libnotify
    libreoffice
    libtool
    light
    loupe
    lsof
    microsoft-edge
    mpg123
    nautilus
    neofetch
    neovide
    networkmanagerapplet
    nwg-look
    optimize
    p7zip
    parallel
    patchelf
    pavucontrol
    pkg-config
    playerctl
    polkit_gnome
    poppler
    pulseaudioFull
    pv
    qalculate-gtk
    rclone
    ripgrep
    slack
    slock
    socat
    sops
    srm
    ssh-to-age
    swaylock-effects
    swww
    teams-for-linux
    telegram-desktop
    termdown
    tldr
    trashy
    tree
    unrar
    unzip
    vlc
    wev
    wf-recorder
    wget
    whatsapp-for-linux
    wirelesstools
    wl-clipboard
    xorg.xhost
    yarn
    zathura
    zip

    # Custom scripts/packages
    # moviesscripts
    bar_themeswitcher
    batplug
    batsuspend
    batwarning
    cliphist_wrapper
    cloud_backup
    gengif
    init_bar
    screenshot
    shade
    sortpics
    wallpaper
    zj_sessions

    # Nix Utilities
    nh
    nix-du
    graphviz # For `nix-du`

    # Development
    air
    automake
    delve
    deno
    gnumake
    go-mockery
    goose
    grpcui
    grpcurl
    lua
    luarocks
    makeWrapper
    mongodb-compass
    nodejs
    postman
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    rustup
    sqlc
    sqlite
    sqlitebrowser
    templ

    nodePackages.prisma
    prisma-engines
    openssl

    (pkgs.python312.withPackages (ppkgs:
      with ppkgs; [
        pip
        inkex
        pyclipper
      ]))
  ];
}
