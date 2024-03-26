{pkgs, ...}: {
  home.packages = with pkgs; [
    calibre
    # mongodb
    mongodb-compass

    # calibre-web
    # scribus
    # torrentstream
    # thunderbird
    # variety
    # checkout this package to handle and use gtk themes
    # NOTE: but if you're going to use it you can't leave the
    # theme configs in home-manager
    # nwg-look

    # vol
    # brightness
    slock
    wallpaper
    cloud_backup
    batplug
    batsuspend
    batwarning

    # wrap-terminal
    acpi
    air
    ark
    autoconf
    automake
    bat
    bc
    bison
    bottom
    brillo
    btrfs-progs
    codeium
    corepack_latest
    dconf
    deno
    docker
    du-dust
    entr
    eva
    eza
    fd
    flex
    font-awesome
    font-manager
    fontforge
    fzf
    gcc
    git
    gnome.gnome-bluetooth
    gnome.gnome-disk-utility
    gnome.nautilus
    gnumake
    go
    grpcui
    grpcurl
    inkscape-with-extensions
    jq
    keepassxc
    libcanberra-gtk3
    libiconv
    libnotify
    libtool
    light
    loupe
    lua
    luarocks
    makeWrapper
    microsoft-edge
    neofetch
    networkmanagerapplet
    nh
    nodejs
    patchelf
    pkg-config
    playerctl
    polkit_gnome
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    rclone
    ripgrep
    rustup
    socat
    swaylock-effects
    swww
    syncthing
    telegram-desktop
    templ
    tldr
    tree
    tribler
    unzip
    vlc
    wget
    wl-clipboard
    xorg.xhost
  ];
}
