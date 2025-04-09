{
  inputs,
  outputs,
  systemConfig,
  config,
  pkgs,
  ...
}: let
  browser = "microsoft-edge";
  browserPkg = "${pkgs.microsoft-edge}/bin/microsoft-edge";
  editor = "nvim";
in {
  imports =
    [
      ./global
    ]
    ++ (
      if !outputs.isWsl
      then [
        inputs.anyrun.homeManagerModules.default

        ./hypr/hyprland.nix
        ./hypr/hypridle.nix
        ./hypr/hyprlock.nix
        ./hypr/hyprshade.nix
        ./hypr/pyprland.nix

        ./anyrun
        ./dunst
        ./inkscape
        ./notifications
        ./pywal
        ./rofi
        ./swappy
        ./vcs
        ./waybar
        ./wlogout
      ]
      else []
    );

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  inherit (systemConfig) colorScheme;

  home = {
    sessionVariables = let
      h = config.home.homeDirectory;
      mh = config.home.sessionVariables.MYHOME;
    in {
      MYHOME = "${h}/myhome";

      DOWNLOADS_DIR = "${mh}/downloads";
      MOVIES_DIR = "${mh}/movies";
      REPOS_DIR = "${mh}/repos";
      PICS_DIR = "${mh}/pictures";
      WALLPAPERS_DIR = "${mh}/pictures/wallpapers/.loop_over";

      # Used by the nix helper `nh`
      FLAKE = "${h}/.dotfiles";
    };

    shellAliases = {
      "." = "cd ${config.home.sessionVariables.FLAKE} && ${config.home.sessionVariables.EDITOR}";

      q = "exit";
      ":q" = "exit";

      # BtrFS aliases
      # https://marc.merlins.org/perso/btrfs/post_2014-05-04_Fixing-Btrfs-Filesystem-Full-Problems.html
      btrfs_balance = "(sudo btrfs balance start -musage=0 / && sudo btrfs balance start -dusage=0 / && sudo btrfs balance start -dusage=20 / &) && while :; do sudo btrfs balance status -v /; sleep 60; done";
      btrfs_df = "sudo btrfs filesystem usage /";
      btrfs_show = "sudo btrfs filesystem show";

      depgraph = "nix-du | dot -Tsvg | display";
    };

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
  };

  # To find the desktop files checkout `/run/current-system/sw/share/applications/`
  xdg.mimeApps = let
    mimeTypes = {
      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
      "video/mp4" = ["vlc.desktop"];
      "x-scheme-handler/magnet" = ["userapp-transmission-gtk-9UFXL2.desktop"];

      "application/x-tar" = ["org.kde.ark.desktop"];
      "application/x-rar" = ["org.kde.ark.desktop"];
      "application/zip" = ["org.kde.ark.desktop"];
      "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];
      "x-scheme-handler/msteams" = ["teams-for-linux.desktop"];

      "text/html" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/unknown" = browser;

      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
    };
  in {
    enable = true;
    associations.added = mimeTypes;
    defaultApplications = mimeTypes;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };
    # iconTheme = {
    #   package = pkgs.gruvboxPlus;
    #   name = "GruvboxPlus";
    # };
    # font = {
    #   name = "Sans";
    #   size = 11;
    # };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk"; # gtk | gnome
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {color-scheme = "prefer-dark";};
    };
  };

  programs.gpg.enable = true;
  services.gpg-agent = let
    day = 86400;
  in {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;

    defaultCacheTtl = day;
    maxCacheTtl = day;
  };

  services.syncthing.enable = true;
  services.udiskie.enable = true;
}
