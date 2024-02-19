{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    distro
    # lock

    # TODO: download after providing space
    # calibre
    # calibre-web
    # scribus
    # torrentstream
    # thunderbird
    # inkscape

    swaylock-effects

    ark
    entr
    font-manager
    gnome.gnome-bluetooth
    jujutsu
    loupe
    socat
    xorg.xhost
    gnome.gnome-disk-utility
    btrfs-progs

    # variety
    # checkout this package to handle and use gtk themes
    # NOTE: but if you're going to use it you can't leave the
    # theme configs in home-manager
    # nwg-look

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
    du-dust

    inkscape-with-extensions
    eza
    fd
    flex
    font-awesome
    fontforge
    fzf
    gcc
    git
    gnumake
    go
    jq
    keepassxc
    libcanberra-gtk3
    libiconv
    libnotify
    libtool
    lua
    luarocks
    makeWrapper
    microsoft-edge
    neofetch
    networkmanagerapplet
    syncthing
    nodejs
    patchelf
    pkg-config
    polkit_gnome
    ripgrep
    rofi-wayland
    rustup
    # starship
    swww
    telegram-desktop
    tldr
    tree
    unzip
    vlc
    wget
    wl-clipboard
    xfce.thunar
    gnome.nautilus
    swaynotificationcenter
    # yazi
    # zoxide
    # atuin
    # table.atuin
  ];
}
