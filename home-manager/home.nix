{
  inputs,
  outputs,
  systemConfig,
  lib,
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
    ./kitty
    ./notifications
    ./nvim
    ./packages
    ./pywal
    ./rofi
    ./swappy
    ./vcs
    ./waybar
    ./wlogout
    ./yazi
    ./dunst
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

  systemd.user.startServices = "sd-switch";

  inherit (systemConfig) colorScheme;

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
      ls = "eza -l --no-time --icons --sort=type";
      ll = "eza -alg --icons --sort=type";
      la = "eza -al --no-time --icons --sort=type";
      l = "eza";

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
    };

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
  };

  programs = {
    home-manager.enable = true;

    thefuck = {
      enable = true;
      enableZshIntegration = true;
    };

    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      matchBlocks = {
        "github.com" = {
          host = "github.com";
          hostname = "github.com";
          identityFile = "~/.ssh/id_rsa_github";
        };
        "gitlab.com" = {
          host = "gitlab.com";
          hostname = "gitlab.com";
          identityFile = "~/.ssh/id_rsa_gitlab";
        };
      };
      extraConfig = ''
        Host 192.168.1.8
            User omar
            PubkeyAcceptedAlgorithms +ssh-rsa
            HostkeyAlgorithms +ssh-rsa

        Host 192.168.1.11
            User omar
            PubkeyAcceptedAlgorithms +ssh-rsa
            HostkeyAlgorithms +ssh-rsa
      '';
    };

    lazygit = {
      enable = true;
      settings = {
        gui.showIcons = true;
        git = {
          paging = {
            colorArgs = "always";
            pager = "delta --dark --diff-so-fancy --paging=never --line-numbers";
          };
        };
      };
    };

    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableAutosuggestions = true;
      enableCompletion = true;
      defaultKeymap = "viins";
      localVariables = {
        ZVM_VI_INSERT_ESCAPE_BINDKEY = "jk";
        ZSH_AUTOSUGGEST_STRATEGY = ["history" "completion"];
      };
      history = {
        expireDuplicatesFirst = true;
        extended = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        path = "${config.xdg.cacheHome}/zsh/zsh_history";
        save = 1000000000;
        size = 1000000000;
      };
      initExtraFirst = "";
      initExtraBeforeCompInit = "";

      initExtra =
        /*
        bash
        */
        ''
          bindkey '^ ' autosuggest-accept
          extract() {
            case $1 in
              *.tar.bz | *.tar.bz2 | *.tar.tbz | *.tar.tbz2)
                foldername="$(basename "''${1%%.*}")"
                [[ ! -d $foldername ]] && mkdir $foldername
                tar xjvf "$1" -C "$foldername"
                ;;
              *.tar.gz | *.tar.tgz)
                foldername="$(basename "''${1%%.*}")"
                [[ ! -d $foldername ]] && mkdir $foldername
                tar xzvf "$1" -C "$foldername"
                ;;
              *.tar.xz | *.tar.txz)
                foldername="$(basename "''${1%%.*}")"
                [[ ! -d $foldername ]] && mkdir $foldername
                tar xJvf "$1" -C "$foldername"
                ;;
              *.zip)
                unzip "$1"
                ;;
              *.rar)
                unrar x "$1"
                ;;
              *.7z)
                7z x "$1"
                ;;
              *)
                echo -e "\e[31mError\e[33m:\e[0m Didn't find a function to exctract $1"
                ;;
            esac
          }

          function ya() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
            ${lib.getExe pkgs.yazi} "$@" --cwd-file="$tmp"
            if cwd="$(\cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
              cd -- "$cwd"
            fi
            rm -f -- "$tmp"
          }
        '';

      prezto = {
        enable = true;
        caseSensitive = false;
        editor = {
          keymap = "vi";
          promptContext = true;
        };
        pmodules = [
          "environment"
          "terminal"
          "editor"
          "history"
          "directory"
          "spectrum"
          "utility"
          "completion"
          "prompt"
        ];
        terminal.autoTitle = true;
      };

      zplug = {
        enable = true;
        plugins = [
          {name = "zsh-users/zsh-autosuggestions";}
          {name = "zsh-users/zsh-completions";}
          {name = "jeffreytse/zsh-vi-mode";}
          {name = "zdharma-continuum/fast-syntax-highlighting";}
        ];
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        format = lib.concatStrings [
          "$directory"
          "$git_branch"
          "$cmd_duration"
          "$line_break"
          "$jobs"
          "$battery"
          "$python"
          "$character"
        ];
        line_break.disabled = true;
        python = {format = "[(($virtualenv) )]($style)";};
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        enter_accept = true;
        keymap_mode = "vim-normal";
        keymap_cursor = {
          emacs = "blink-bar";
          vim_insert = "blink-bar";
          vim_normal = "blink-block";
        };
        stats = {
          common_prefix = ["sudo"];
          common_subcommands = ["cargo" "go" "git" "npm" "yarn" "pnpm" "docker" "kubectl"];
        };
      };
    };
  };

  # To find the desktop files checkout `/run/current-system/sw/share/applications/`
  xdg.mimeApps = let
    mimeTypes = {
      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
      "application/x-tar" = ["org.kde.ark.desktop"];
      "video/mp4" = ["vlc.desktop"];
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

  services.syncthing = {enable = true;};
  services.udiskie = {enable = true;};
}
