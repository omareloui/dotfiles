{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = let
    p = config.colorScheme.palette;
    terminalEmulator = lib.getExe pkgs.wezterm;
  in {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      monitor = "eDP-1, 1920x1080, 0x0, 1";
      workspace = "1, monitor:eDP-1, default:true";

      general = {
        gaps_in = 5;
        gaps_out = 14;
        border_size = 2;
        "col.active_border" = "rgba(${p.base0B}ee) rgba(${p.base0D}ee) 45deg";
        "col.inactive_border" = "rgba(${p.base04}aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      input = {
        kb_layout = "us,eg";
        kb_options = "grp:alt_shift_toggle";
        repeat_rate = 30;
        repeat_delay = 300;
        numlock_by_default = 1;
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          clickfinger_behavior = false;
          tap-to-click = true;
          drag_lock = false;
        };
      };

      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 10;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
          blurls = "waybar";
        };

        active_opacity = 1.0;
        inactive_opacity = 0.85;
        fullscreen_opacity = 1.0;
        "col.shadow" = "0x66000000";

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
      };

      animations = {
        enabled = true;
        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"

          "overshot1, 0.05, 0.9, 0.1, 1.05"
          "smoothOut, 0.5, 0, 0.99, 0.99"
          "smoothIn, 0.5, -0.5, 0.68, 1.5"

          "linear, 0.0, 0.0, 1.0, 1.0"
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "slow, 0, 0.85, 0.3, 1"
          "overshot2, 0.7, 0.6, 0.1, 1.1"
          "bounce, 1.1, 1.6, 0.1, 0.85"
          "sligshot, 1, -1, 0.15, 1.25"
          "nice, 0, 6.9, 0.5, -4.20"
        ];
        animation = [
          # "windows, 1, 7, myBezier"
          # "windowsOut, 1, 7, default, popin 80%"
          # "border, 1, 10, default"
          # "borderangle, 1, 8, default"
          # "fade, 1, 7, default"
          # "workspaces, 1, 6, default"

          # "windows, 1, 5, overshot1, slide"
          # "windowsOut, 1, 3, smoothOut"
          # "windowsIn, 1, 3, smoothOut"
          # "windowsMove, 1, 4, smoothIn, slide"
          # "border, 1, 5, default"
          # "fade, 1, 5, smoothIn"
          # "fadeDim, 1, 5, smoothIn"
          # "workspaces, 1, 6, default"

          "windowsIn, 1, 5, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 10, linear"
          "borderangle, 1, 180, linear, loop #used by rainbow borders and rotating colors"
          "fade, 1, 5, overshot2"
          "workspaces, 1, 5, wind"
          "windows, 1, 5, bounce, slide"
        ];
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_invert = true;
        workspace_swipe_create_new = true;
        workspace_swipe_forever = false;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 400;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.5;
      };

      master = {
        new_status = "slave";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_resizing = true;
        force_split = 2;
      };

      exec = [
        "avizo-service"
        "${lib.getExe pkgs.swaynotificationcenter}"
        "${lib.getExe pkgs.init_bar}"
        "${lib.getExe pkgs.hyprshade} auto"
      ];

      exec-once = [
        "${lib.getExe pkgs.hypridle}"
        "${lib.getExe pkgs.pyprland}"
        "${lib.getExe pkgs.swww} init"
        "${lib.getExe pkgs.xorg.xhost} +SI:${config.home.username}:root" # fixes the bluetooth stutter
        "${lib.getExe pkgs.telegram-desktop} -startintray"
        # "${lib.getExe pkgs.slack}"

        "wl-paste --watch cliphist store"

        "dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE"
      ];

      windowrulev2 = let
        shouldFloatClasses = "transmission-gtk|org\.gnome\.Loupe|pavucontrol|scratchpad|nm-connection-editor|org\.keepassxc\.KeePassXC";
        scratpad = "class:^scratchpad$";
        bluetoothClientRe = "^\.blueman-manager-wrapped$";
        fileSelectorTitleRe = "^(Select file to open)$";
        fileSelectorClassRe = "^(xdg-desktop-portal-gtk)$";
        pipRe = "Picture[\- ]in[\- ][Pp]icture";
      in [
        "workspace special silent, ${scratpad}"
        "stayfocused, ${scratpad}"

        # "stayfocused, title:^TelegramDesktop$"
        # "stayfocused, class:^\.telegram-desktop-wrapped&,title:^Choose export folder$"

        "float, class:^(${shouldFloatClasses})$"
        "center 1, class:^(${shouldFloatClasses})$"
        "size 1200 760, class:^(${shouldFloatClasses})$"

        "float, class:${bluetoothClientRe}"
        "center 1, class:${bluetoothClientRe}"
        "size 750 445, class:${bluetoothClientRe}"

        "float, title:${fileSelectorTitleRe}"
        "center 1, title:${fileSelectorTitleRe}"
        "size 1160 680, title:${fileSelectorTitleRe}"

        "float, class:${fileSelectorClassRe}"
        "center 1, class:${fileSelectorClassRe}"
        "size 1160 680, class:${fileSelectorClassRe}"

        "float, class:^thunar$,title:^(File Operation Progress)$"
        "float, class:^org.inkscape.Inkscape$,title:^(|Measure Path|PDF Import Settings|Calender|Frame|Offset Paths)$"

        "size 960 520, class:^transmission-gtk$,title:^Transmission$"
        "size 482 567, class:^transmission-gtk$,title:^Torrent Options$"

        "opacity 0.95 0.95, class:^(microsoft-edge)$"
        "opacity 0.95 0.8, class:^(kitty|org\.wezfurlong\.wezterm)$"
        "opacity 0.85 0.8, class:^(org.gnome.Nautilus)$"

        "bordercolor rgb(${p.base00}) rgb(${p.base01}), floating:1"

        "opacity 1 1, title:^(${pipRe})$"
        "pin, title:^(${pipRe})$"
        "float, title:^(${pipRe})$"
        "size 25% 25%, title:^(${pipRe})$"
        "move 74% 73%, title:^(${pipRe})$"
      ];

      layerrule = [
        "unset, rofi"
        "blur, rofi"
        "ignorezero, rofi"

        "blur, wlogout"
        "blur, class:^(swww)$"

        "blur, swaync-control-center"
        "blur, swaync-notification-window"

        "ignorezero, swaync-control-center"
        "ignorezero, swaync-notification-window"

        "ignorealpha 0.5, swaync-control-center"
        "ignorealpha 0.5, swaync-notification-window"
      ];

      misc = {
        enable_swallow = false;
        swallow_regex = "^(Alacritty|kitty|wezterm|footclient|scratchpad)$";
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };

      "$mainMod" = "SUPER";
      bind =
        [
          # window manipulation
          "$mainMod, escape, exec, ${lib.getExe pkgs.wlogout} -b 5 -T 400 -B 400"
          "$mainMod, Q, killactive,"
          "$mainMod, F, fullscreen,"
          "$mainMod, C, pseudo, dwindle"

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

          # Groups
          "$mainMod SHIFT, V, togglegroup"
          "$mainMod, N, changegroupactive, f"
          "$mainMod SHIFT, N, changegroupactive, b"

          # Hypdland misc
          "$mainMod SHIFT, R, exec, hyprctl reload"

          # Laptop keys
          ",XF86MonBrightnessUp, exec, lightctl up"
          ",XF86MonBrightnessDown, exec, lightctl down"
          ",XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause"
          ",XF86AudioRaiseVolume, exec, volumectl -u up"
          ",XF86AudioLowerVolume, exec, volumectl -u down"
          ",XF86AudioMute, exec, volumectl toggle-mute"
          ",XF86Calculator, exec, ${lib.getExe pkgs.qalculate-gtk}"

          "$mainMod, A, exec, hyprctl switchxkblayout"

          # Plugins
          "$mainMod SHIFT, B, exec, pypr toggle btm && hyprctl dispatch bringactivetotop"
          "$mainMod SHIFT, T, exec, pypr toggle term && hyprctl dispatch bringactivetotop"
          "$mainMod SHIFT, E, exec, pypr toggle yazi && hyprctl dispatch bringactivetotop"

          # Apps keybindings
          "$mainMod, Return, exec, ${terminalEmulator}"
          "$mainMod SHIFT, Return, exec, ${lib.getExe pkgs.zj_sessions}"
          "$mainMod, B, exec, [workspace 1] microsoft-edge"
          "$mainMod, T, exec, ${lib.getExe pkgs.telegram-desktop}"
          "$mainMod, N, exec, nm-connection-editor"
          "$mainMod, U, exec, blueman-manager"
          "$mainMod, E, exec, ${lib.getExe pkgs.nautilus}"

          "$mainMod SHIFT, N, exec, swaync-client -t"

          # Scripts
          "$mainMod, R, exec, ${lib.getExe pkgs.rofi-wayland} -show drun"
          # "$mainMod, R, exec, ${lib.getExe inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins}"
          "$mainMod, V, exec, ${lib.getExe pkgs.cliphist_wrapper} list"

          "$mainMod, W, exec, ${lib.getExe pkgs.wallpaper}"

          "$mainMod CTRL SHIFT, R, exec, ${lib.getExe pkgs.init_bar}"

          ", Print, exec, ${lib.getExe pkgs.screenshot} -s 3 full"
          "$mainMod, Print, exec, ${lib.getExe pkgs.screenshot} -p area"
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
  };
}
