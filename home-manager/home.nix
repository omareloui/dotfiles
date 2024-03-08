{
  inputs,
  outputs,
  systemConfig,
  lib,
  config,
  pkgs,
  ...
}: {
  home.stateVersion = "23.11";

  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    inputs.nix-colors.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim

    ./hyprland
    ./kitty
    ./notifications
    ./nvim
    ./packages
    ./rofi
    ./swaylock
    ./yazi
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
  home = {
    username = "omareloui";
    homeDirectory = "/home/omareloui";
  };

  colorScheme = systemConfig.colorScheme;

  programs.home-manager.enable = true;

  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "Omar Eloui";
    userEmail = "contact@omareloui.com";
    extraConfig = {
      init = {defaultBranch = "main";};
      core = {
        editor = "nvim";
        sshCommand = "ssh -i ~/.ssh/id_rsa_github";
      };
      push = {autoSetupRemote = true;};
    };
    delta = {
      enable = true;
      options = {
        side-by-side = true;
        diff-so-fancy = true;
        line-numbers = true;
      };
    };
    aliases = {
      uc = "reset HEAD^ --soft";
      uncommit = "reset HEAD^ --soft";
      l = ''
        log --pretty=format:"%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --graph --date=relative --decorate --all'';
    };
  };

  programs.ssh = {
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

  programs.lazygit = {
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

  # programs.eww = {
  #   enable = true;
  #   # TODO: update the path (make it in the same directory as the eww/default.nix or whatever it will be)
  #   # TODO: make the files nix embeded
  #   package = pkgs.eww.override {withWayland = true;};
  #   configDir = "${config.home.sessionVariables.DOTFILES}/nix.wip/assets/eww/bar";
  # };

  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = lib.getExe pkgs.slock;
        text = "Lock (l)";
        keybind = "l";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot (r)";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown (s)";
        keybind = "s";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit 0";
        text = "Logout (e)";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend (u)";
        keybind = "u";
      }
    ];
    # style = ''
    #   window {
    #     background: #16191c;
    #   }
    #   button {
    #     color: #16191c;
    #   }
    # '';
  };

  # TODO: readd the comments from main dunst file after moving to another file
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # TODO: check the font
        font = "Product Sans";
        allow_markup = true;
        format = ''
          <b>%s</b>
          %b'';
        sort = true;
        indicate_hidden = true;
        alignment = "left";
        bounce_freq = 0;
        ellipsize = "middle";
        show_age_threshold = -1;
        word_wrap = true;
        ignore_newline = false;
        width = "(300, 600)";
        height = 500;
        origin = "top-right";
        offset = "20x20";
        progress_bar = true;
        progress_bar_height = 14;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        frame_width = 3;
        frame_color = "#1E1E2E";
        transparency = 0;
        idle_threshold = 0;
        monitor = 0;
        follow = "none";
        show_indicators = false;
        sticky_history = true;
        line_height = 8;
        separator_height = 3;
        padding = 16;
        horizontal_padding = 12;
        text_icon_padding = 16;
        separator_color = "auto";
        startup_notification = false;
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 128;
        corner_radius = 10;
        always_run_script = true;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
      };

      urgency_low = {
        timeout = 6;
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        frame_color = "#191d24";
        highlight = "#89B4FA";
      };

      urgency_normal = {
        timeout = 6;
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        frame_color = "#0d0f16";
        highlight = "#89B4FA";
      };

      urgency_critical = {
        # TODO: add the script
        # script = "~/.config/dunst/scripts/playNotificationSound.sh";
        timeout = 0;
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        frame_color = "#0d0f16";
        highlight = "#F38BA8";
      };
    };
  };

  home.sessionVariables = {
    PATH = builtins.concatStringsSep ":" [
      "$PATH"
      "/usr/local/go/bin"
      "/usr/local/bin"
      "${config.home.homeDirectory}/.local/share/pnpm"
      "${config.home.homeDirectory}/.cargo/bin"
      "${config.home.homeDirectory}/.deno/bin"
      "${config.home.homeDirectory}/.local/bin"
      "${config.home.homeDirectory}/bin"
    ];

    LANG = "en_US.UTF-8";

    VISUAL = "nvim";
    EDITOR = "nvim";

    MYHOME = "${config.home.homeDirectory}/myhome";

    REPOS_DIR = "${config.home.sessionVariables.MYHOME}/repos";
    MOVIES_DIR = "${config.home.sessionVariables.MYHOME}/movies";
    PICS_DIR = "${config.home.sessionVariables.MYHOME}/pictures";
    WALLPAPERS_DIR = "${config.home.sessionVariables.MYHOME}/pictures/wallpapers";

    NVM_DIR = "${config.home.homeDirectory}/.nvm";
    FLAKE = "${config.home.homeDirectory}/.dotfiles";
  };

  home.shellAliases = {
    # zshconfig = "$EDITOR ~/.config/zsh/.zshrc";
    # reload = "source $ZDOTDIR/.zshrc";

    ls = "eza -l --no-time --icons --sort=type";
    ll = "ls -alF";
    la = "ls -a";
    l = "eza";

    # neovide = "env -u WAYLAND_DISPLAY neovide"

    # py = "python3";
    # ve = "python3 -m venv ./env";
    # va = "source ./env/bin/activate";

    q = "exit";
    ":q" = "exit";

    cat = "bat --color always --plain";
    # grep = "grep --color=auto";
    du = "dust";

    # update = "paru -Syu";
    # rmcache = "paru -Sccd";

    clean_docker = "docker builder prune -a --force";

    ns = "nh os switch";
    ng = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";

    hm = "home-manager";
    hs = "nh home switch";

    distro = "cat /etc/*-release | awk -F'=' '/DISTRIB_ID/ {print $2}'";
  };

  programs.zsh = {
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

  programs.starship = {
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

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.atuin = {
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

  # To find the desktop files checkout `/run/current-system/sw/share/applications/`
  xdg.mimeApps = let
    mimeTypes = {
      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
      "application/x-tar" = "org.kde.ark.desktop";
    };
  in {
    enable = true;
    associations.added = mimeTypes;
    defaultApplications = mimeTypes;
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
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

  services.syncthing = {
    enable = true;
    # dataDir = "${config.home.homeDirectory}/documents/syncthing";
    # configDir = "${config.home.homeDirectory}/documents/syncthing/.config/syncthing";
    # overrideDevices = true; # overrides any devices added or deleted through the WebUI
    # overrideFolders = true; # overrides any folders added or deleted through the WebUI
    # settings = {
    #   devices = {
    #     "A24" = {id = "DEVICE_ID";};
    #   };
    #   folders = {
    #     "default" = {
    #       path = "${config.home.homeDirectory}/documents/syncthing"; # Which folder to add to Syncthing
    #       devices = ["A24"];
    #     };
    #   };
    # };
  };
  # home.file.".local/state/syncthing/config.xml".text =
  #   builtins.toXML [];

  # TODO: doesn't work for now!
  # services.gpg-agent = {
  #   enable = true;
  #   defaultCacheTtl = 1800;
  #   enableSshSupport = true;
  # };
}
