{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.stateVersion = "23.11";

  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages

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

  # home.packages = with pkgs; [ ];

  programs.home-manager.enable = true;

  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        ratio = [1 4 3];
        linemode = "size";
      };
    };
    keymap = {
      manager = {
        prepend_keymap = [
          {
            on = ["l"];
            exec = "plugin --sync smart-enter";
            desc = "Enter the child directory, or open the file";
          }
          {
            on = ["w"];
            # TODO: update the script after moving the script to nix
            exec = "shell --confirm '~/.dotfiles/scripts/wallpaper $1'";
            desc = "Set the image as wallpaper";
          }
          {
            on = ["A"];
            exec = ''
              shell --block --confirm '
                read -p "Write directory name: " dir
                mkdir -p $dir
                mv $@ $dir
              '
            '';
            desc = "Add selected to a new directory";
          }
          {
            on = ["F"];
            exec = ''
              shell --confirm '
                for folder in $@; do
                  if [[ -d $folder ]]; then
                    fd -IHd1 . "$folder" | xargs -I{} mv {} .
                    rmdir "$folder"
                  fi
                done
              '
            '';
            desc = "Flatten the selected directories";
          }
        ];
      };
    };
  };
  home.file.".config/yazi/plugins/smart-enter.yazi/init.lua".text =
    /*
    lua
    */
    ''
      return {
      	entry = function()
      		local h = cx.active.current.hovered
      		ya.manager_emit(h and h.cha.is_dir and "enter" or "open", {})
      	end,
      }
    '';

  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
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

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.xwayland.enable = true;
  wayland.windowManager.hyprland.systemd.enable = true;

  wayland.windowManager.hyprland.settings = {
    monitor = "eDP-1, 1920x1080, 0x0, 1";
    workspace = "1, monitor:eDP-1, default:true";

    exec-once = [
      # "~/.autostart"
      # "eww open bar"
      "swww init"
      # "nm-applet --indeicator"
      "dunst"
    ];
    exec = ["libinput-gestures-setup restart"];

    input = {
      kb_layout = "us";
      follow_mouse = 1;
      touchpad = {natural_scroll = "yes";};
      sensitivity = 0;
    };

    animations = {
      enabled = "yes";
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    dwindle = {
      pseudotile = "yes";
      preserve_split = "yes";
    };

    gestures = {
      workspace_swipe = "on";
      workspace_swipe_invert = true;
    };

    "device:epic mouse V1" = {sensitivity = -0.5;};

    misc = {
      disable_splash_rendering = true;
      disable_hyprland_logo = true;
    };

    master = {new_is_master = false;};

    windowrule = [
      "float, transmission"
      "float, eog"
      "float, pavucontrol"
      "float, vlc"
      "float, blueman-manager"
    ];
    windowrulev2 = [
      "float, class:^thunar$,title:^(File Operation Progress)$"
      "float, class:^org.inkscape.Inkscape$,title:^(Measure Path)$"
      "float, class:^org.kde.kdeconnect.*$"
    ];

    general = {
      gaps_in = 5;
      gaps_out = 20;
      border_size = 2;
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";
      layout = "dwindle";
      allow_tearing = false;
    };

    decoration = {
      rounding = 10;

      blur = {
        enabled = true;
        size = 8;
        passes = 1;
        vibrancy = 0.1696;
      };

      drop_shadow = true;
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";
    };

    "$mainMod" = "SUPER";
    bind =
      [
        # window manipulation
        "$mainMod, escape, exec, ${lib.getExe pkgs.wlogout} -b 5 -T 400 -B 400"
        "$mainMod SHIFT, R, exec, hyprctl reload"
        "$mainMod, Q, killactive,"
        "$mainMod, C, pseudo,"
        "$mainMod, F, fullscreen,"

        # apps keybindings
        "$mainMod, B, exec, microsoft-edge-stable"
        "$mainMod, T, exec, telegram-desktop"
        "$mainMod, Return, exec, kitty"

        ",Print,exec,~/.local/bin/screenshot -s 3 full"
        "$mainMod,Print,exec,~/.local/bin/screenshot -p area"

        "$mainMod SHIFT, T, exec, swaync-client -t"

        "$mainMod, E, exec, thunar"
        # TODO: check how to add this script
        "$mainMod, R, exec, ~/.dotfiles/config/hypr/scripts/appLaunch/launcher.sh"
        "$mainMod, P, pseudo, # dwindle"

        # Move focus with mainMod + vim keys
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        "$mainMod, tab, workspace, +1"
        "$mainMod SHIFT, tab, workspace, -1"

        # Move windows in workspace
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

        # Resize in workspace
        "$mainMod CONTROL, h, splitratio, -0.1"
        "$mainMod CONTROL, l, splitratio, +0.1"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Layout
        "$mainMod CTRL, Space, togglefloating"
        "$mainMod, Space, togglesplit"

        "$mainMod SHIFT, V, togglegroup"
        "$mainMod, N, changegroupactive, f"
        "$mainMod SHIFT, N, changegroupactive, b"

        # Laptop keys
        ",XF86MonBrightnessUp, exec, ~/.local/bin/brightness up"
        ",XF86MonBrightnessDown, exec, ~/.local/bin/brightness down"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioRaiseVolume, exec, ~/.local/bin/volume up"
        ",XF86AudioLowerVolume, exec, ~/.local/bin/volume down"
        ",XF86AudioMute, exec, ~/.local/bin/volume mute"

        # misc
        "$mainMod, W, exec, ~/.local/bin/wallpaper"
      ]
      ++ (
        # workspaces
        # binds $mainMod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (x: let
            ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in [
            "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
            "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ])
          10)
      );

    bindm = ["$mainMod, mouse:272, movewindow" "$mainMod, mouse:273, resizewindow"];
  };

  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "~/.local/bin/lock";
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
      "${config.xdg.dataHome}/.local/share/pnpm"
      "${config.xdg.dataHome}/.cargo/bin"
      "${config.xdg.dataHome}/.deno/bin"
      "${config.xdg.dataHome}/.local/bin"
      "${config.xdg.dataHome}/bin"
    ];

    LANG = "en_US.UTF-8";

    VISUAL = "nvim";
    EDITOR = "nvim";

    DOTFILES = "${config.home.homeDirectory}/.dotfiles";
    DOTFILES_ASSETS = "${config.home.sessionVariables.DOTFILES}/assets";
    DOTFILES_CONFIG = "${config.home.sessionVariables.DOTFILES}/config";
    SCRIPTS = "${config.home.sessionVariables.DOTFILES}/scripts";
    BOOTSTRAP_FILES = "${config.home.sessionVariables.DOTFILES}/bootstrap";

    REPOS_DIR = "${config.xdg.dataHome}/repos";
    MUSIC_DIR = "${config.xdg.dataHome}/Music";
    MOVIES_DIR = "${config.xdg.dataHome}/Movies";
    NVM_DIR = "${config.xdg.dataHome}/.nvm";

    # TODO: fix this
    # DISTRO = ''$("${config.xdg.dataHome}/.local/bin/distro")'';
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

    nr = "nixos-rebuild";
    nf = "nr --flake ~/.dotfiles/nix.wip";
    ns = "nf switch";

    hm = "home-manager";
    hf = "hm --flake ~/.dotfiles/nix.wip";
    hs = "hf switch";
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
          if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
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

  programs.kitty = {
    enable = true;
    # `kitty list-fonts` to choose a font
    # `kitty --debug-font-fallback` to know which font is applied
    font = {
      name = "FiraCode Nerd Font Mono";
      package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
      size = 12;
    };
    shellIntegration.enableZshIntegration = true;
    settings = {
      enable_audio_bell = false;
      remember_window_size = false;
      initial_window_width = "95c";
      initial_window_height = "35c";
      window_padding_width = 0;
      confirm_os_window_close = 0;
      wayland_titlebar_color = "background";
      macos_titlebar_color = "background";
      hide_window_decorations = true;
      background_opacity = "0.7";
      foreground = "#a9b1d6";
      background = "#1a1b26";
      color0 = "#414868";
      color8 = "#414868";
      color1 = "#f7768e";
      color9 = "#f7768e";
      color2 = "#73daca";
      color10 = "#73daca";
      color3 = "#e0af68";
      color11 = "#e0af68";
      color4 = "#7aa2f7";
      color12 = "#7aa2f7";
      color5 = "#bb9af7";
      color13 = "#bb9af7";
      color6 = "#7dcfff";
      color14 = "#7dcfff";
      color7 = "#c0caf5";
      color15 = "#c0caf5";
      cursor = "#c0caf5";
      cursor_text_color = "#1a1b26";
      selection_foreground = "none";
      selection_background = "#28344a";
      url_color = "#9ece6a";
      active_border_color = "#3d59a1";
      inactive_border_color = "#101014";
      bell_border_color = "#e0af68";
      tab_bar_style = "fade";
      tab_fade = 1;
      active_tab_foreground = "#3d59a1";
      active_tab_background = "#16161e";
      active_tab_font_style = "bold";
      inactive_tab_foreground = "#787c99";
      inactive_tab_background = "#16161e";
      inactive_tab_font_style = "bold";
      tab_bar_background = "#101014";
    };
    keybindings = {
      "kitty_mod+t" = "new_tab_with_cwd";
      "kitty_mod+enter" = "new_window_with_cwd";
      "kitty_mod+l" = "next_tab";
      "kitty_mod+h" = "previous_tab";
      "kitty_mod+right" = "no_op";
      "kitty_mod+left" = "no_op";
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
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
    };
    defaultApplications = {
      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
    };
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
