{
  inputs,
  outputs,
  systemConfig,
  config,
  pkgs,
  ...
}: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    inputs.nix-colors.homeManagerModules.default

    ./hypr/hyprland.nix
    ./hypr/hypridle.nix
    ./hypr/hyprlock.nix
    ./hypr/hyprshade.nix
    ./hypr/pyprland.nix

    ./anyrun
    ./atuin
    ./dunst
    ./eza
    ./kitty
    ./lazygit
    ./notifications
    ./nvim
    ./packages
    ./pywal
    ./rofi
    ./ssh
    ./starship
    ./swappy
    ./thefuck
    ./vcs
    ./waybar
    ./wlogout
    ./yazi
    ./zoxide
    ./zsh
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications

      # outputs.overlays.stable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  inherit (systemConfig) colorScheme;
  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;
  home = {
    stateVersion = "23.11";

    username = "omareloui";
    homeDirectory = "/home/omareloui";

    sessionVariables = let
      h = config.home.homeDirectory;
      mh = config.home.sessionVariables.MYHOME;
    in {
      PATH = builtins.concatStringsSep ":" [
        "$PATH"
        "/usr/local/go/bin"
        "/usr/local/bin"
        "${h}/.local/share/pnpm"
        "${h}/.cargo/bin"
        "${h}/.deno/bin"
        "${h}/.local/bin"
        "${h}/bin"
      ];

      LANG = "en_US.UTF-8";

      VISUAL = "nvim";
      EDITOR = "nvim";

      MYHOME = "${h}/myhome";

      DOWNLOADS_DIR = "${mh}/downloads";
      MOVIES_DIR = "${mh}/movies";
      REPOS_DIR = "${mh}/repos";
      PICS_DIR = "${mh}/pictures";
      WALLPAPERS_DIR = "${mh}/pictures/wallpapers/.loop_over";

      _ZO_EXCLUDE_DIRS = "${h}:${mh}/**/.private/**:${mh}/**/.private";

      NVM_DIR = "${h}/.nvm";
      FLAKE = "${h}/.dotfiles";
    };

    shellAliases = {
      dot = "z ${config.home.homeDirectory}/.dotfiles && ${config.home.sessionVariables.EDITOR}";

      # py = "python3";
      # ve = "python3 -m venv ./env";
      # va = "source ./env/bin/activate";

      q = "exit";
      ":q" = "exit";

      cat = "bat --color always --plain";
      du = "dust";

      lg = "lazygit";

      update = "nix flake update";

      clean_docker = "docker builder prune -a --force";

      ns = "nh os switch";
      ng = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";

      hm = "home-manager";
      hs = "nh home switch";

      distro = "cat /etc/*-release | awk -F'=' '/DISTRIB_ID/ {print $2}'";

      pnpx = "pnpm dlx";
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
    };
  in {
    enable = true;
    associations.added = mimeTypes;
    defaultApplications = mimeTypes;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome.gnome-themes-extra;
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
    platformTheme = "gtk"; # gtk | gnome
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {color-scheme = "prefer-dark";};
    };
  };

  services.syncthing.enable = true;
  services.udiskie.enable = true;
}
