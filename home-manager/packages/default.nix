{pkgs, ...}: {
  home.packages = with pkgs; [
    # calibre
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
    inkscape-with-extensions
    jq
    jujutsu
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
    rclone
    ripgrep
    rustup
    socat
    swaylock-effects
    swww
    syncthing
    telegram-desktop
    # templ
    tldr
    tree
    unzip
    vlc
    wget
    wl-clipboard
    xorg.xhost

    slock
    vol
    brightness
    wallpaper
    cloud_backup
    batplug
    batsuspend
    batwarning
  ];
}
