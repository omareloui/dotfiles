{pkgs, ...}: {
  home.packages = with pkgs; [
    # mongodb

    # moviesscripts
    acpi
    age
    ark
    autoconf
    bar_themeswitcher
    bat
    batplug
    batsuspend
    batwarning
    bc
    bison
    bottom
    brillo
    btrfs-progs
    calibre
    cliphist
    cliphist_wrapper
    cloc
    cloud_backup
    codeium
    corepack_latest
    dconf
    du-dust
    entr
    eva
    fd
    ffmpeg
    file
    flex
    font-awesome
    font-manager
    fontforge
    fzf
    gcc
    gh
    ghostscript
    git
    gnome-disk-utility
    gnome.gnome-bluetooth
    group_likes
    hyprpicker
    imagemagick
    init_bar
    jq
    keepassxc
    kora-icon-theme
    libcanberra-gtk3
    libiconv
    libnotify
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
    parallel
    patchelf
    pavucontrol
    pkg-config
    playerctl
    polkit_gnome
    poppler
    qalculate-gtk
    rclone
    ripgrep
    screenshot
    shade
    slack
    slock
    socat
    sops
    sortpics
    srm
    ssh-to-age
    swaylock-effects
    swww
    syncthing
    telegram-desktop
    tldr
    trashy
    tree
    unrar
    unzip
    vlc
    wallpaper
    wev
    wget
    wirelesstools
    wl-clipboard
    xorg.xhost
    yarn
    zathura
    zip

    # Nix Utilities
    nh
    nix-du
    graphviz # For `nix-du`

    # Development
    air
    automake
    deno
    gnumake
    go-mockery
    grpcui
    grpcurl
    lua
    luarocks
    makeWrapper
    mongodb-compass
    nodejs
    postman
    # nodePackages.prisma
    # prisma-engines
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    rustup
    templ

    (pkgs.python311.withPackages (ppkgs:
      with ppkgs; [
        pip
        inkex
        pyclipper
      ]))
  ];
}
