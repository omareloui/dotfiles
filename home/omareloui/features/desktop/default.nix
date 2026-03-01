{pkgs, ...}: {
  imports = [
    ./hypr
    ./inkscape

    ./qt.nix
    ./gtk.nix

    ./ark.nix
    ./kitty.nix
    # ./libreoffice.nix
    ./loupe.nix
    ./ms-edge.nix
    ./swww.nix
    ./teams.nix
    ./telegram.nix
    ./tranmission.nix
    ./vlc.nix
    ./zathura.nix
    ./zen.nix

    ./catppuccin.nix
  ];

  home = {
    packages = with pkgs; [
      acpi
      brillo
      btrfs-progs
      # calibre
      cliphist
      font-awesome
      font-manager
      fontforge
      gnome-bluetooth
      gnome-disk-utility
      hyprpicker
      kdePackages.dolphin
      keepassxc
      kora-icon-theme
      libcanberra-gtk3
      libiconv
      libnotify
      libtool
      libusb1
      light
      localsend
      nautilus
      networkmanagerapplet
      nwg-look
      pavucontrol
      pulseaudioFull
      qalculate-gtk
      slack
      slock
      swaylock-effects
      wasistlos
      wf-recorder
      wirelesstools
      xhost

      # Custom scripts/packages
      bar_themeswitcher
      batplug
      batsuspend
      batwarning
      cliphist_wrapper
      init_bar
      screenshot
      shade
      wallpaper
    ];

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  xdg.portal.enable = true;

  # To find the desktop files checkout `/run/current-system/sw/share/applications/`
  xdg.mimeApps.enable = true;
}
