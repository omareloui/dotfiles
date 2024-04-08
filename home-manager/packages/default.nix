{
  pkgs,
  inputs,
  ...
}: {
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
    cliphist
    cliphist_wrapper
    cloud_backup
    codeium
    corepack_latest
    dconf
    deno
    docker
    du-dust
    entr
    eva
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
    kora-icon-theme
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
    qalculate-gtk
    rclone
    ripgrep
    rustup
    screenshot
    shade
    slock
    socat
    sortpics
    swaylock-effects
    swww
    syncthing
    telegram-desktop
    templ
    tldr
    trashy
    tree
    tribler
    unzip
    vlc
    wallpaper
    wev
    wget
    wirelesstools
    wl-clipboard
    xorg.xhost
    zathura

    (pkgs.python311.withPackages (ppkgs: [
      ppkgs.pip
    ]))
  ];
}
