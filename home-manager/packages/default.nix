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
    # wrap-terminal

    acpi
    air
    ark
    autoconf
    automake
    bat
    batplug
    batsuspend
    batwarning
    bc
    bison
    bottom
    brillo
    btrfs-progs
    cloud_backup
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
    ffmpeg
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
    hyprpicker
    imagemagick
    init_bar
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
    pavucontrol
    pkg-config
    playerctl
    polkit_gnome
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    python3
    qalculate-gtk
    rclone
    ripgrep
    rustup
    screenshot
    slock
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
    wallpaper
    wget
    wl-clipboard
    xorg.xhost
  ];
}
