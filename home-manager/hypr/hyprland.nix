{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

    # plugins = [
    #   inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    # ];

    settings = {
      monitor = "eDP-1, 1920x1080, 0x0, 1";
      workspace = "1, monitor:eDP-1, default:true";

      general = {
        gaps_in = 5;
        gaps_out = 14;
        border_size = 2;
        "col.active_border" = "rgba(${config.colorScheme.palette.base0B}ee) rgba(${config.colorScheme.palette.base0D}ee) 45deg";
        "col.inactive_border" = "rgba(${config.colorScheme.palette.base04}aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {natural_scroll = "yes";};
        sensitivity = 0;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 12;
          passes = 4;
          new_optimizations = "on";
          ignore_opacity = true;
          xray = false;
          blurls = "waybar";
        };

        active_opacity = 1.0;
        inactive_opacity = 0.8;
        fullscreen_opacity = 1.0;
        "col.shadow" = "0x66000000";

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
      };

      animations = {
        # enabled = "yes";
        # bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        # animation = [
        #   "windows, 1, 7, myBezier"
        #   "windowsOut, 1, 7, default, popin 80%"
        #   "border, 1, 10, default"
        #   "fade, 1, 7, default"
        #   "workspaces, 1, 6, default"
        # ];
        enabled = true;
        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
          "overshot, 0.05, 0.9, 0.1, 1.05"
          "smoothOut, 0.5, 0, 0.99, 0.99"
          "smoothIn, 0.5, -0.5, 0.68, 1.5"
        ];
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"

          # "windows, 1, 5, overshot, slide"
          # "windowsOut, 1, 3, smoothOut"
          # "windowsIn, 1, 3, smoothOut"
          # "windowsMove, 1, 4, smoothIn, slide"
          # "border, 1, 5, default"
          # "fade, 1, 5, smoothIn"
          # "fadeDim, 1, 5, smoothIn"
          # "workspaces, 1, 6, default"
        ];
      };

      gestures = {
        workspace_swipe = "on";
        workspace_swipe_invert = true;
      };

      master = {
        new_is_master = false;
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      exec = [
        "avizo-service"
        "${lib.getExe pkgs.init_bar}"
        "${lib.getExe pkgs.swaynotificationcenter}"
      ];

      exec-once = [
        "${lib.getExe pkgs.hypridle}"
        "${lib.getExe pkgs.pyprland}"
        "${lib.getExe pkgs.swww} init"
        "${lib.getExe pkgs.xorg.xhost} +SI:${config.home.username}:root" # to fix the bluetooth stutter

        "${lib.getExe pkgs.telegram-desktop} -startintray"
        "wl-paste --watch cliphist store"
      ];

      windowrulev2 = let
        shouldFloat = "tribler|org.gnome.Loupe|pavucontrol|vlc|.blueman-manager-wrapped|scratchpad|nm-connection-editor";
        scratpad = "class:^scratchpad$";
        # scratpadsize = "80% 85%";
      in [
        "float, class:^(${shouldFloat})$"
        "center 1, class:^(${shouldFloat})$"

        # "size ${scratpadsize}, ${scratpad}"
        "workspace special silent, ${scratpad}"

        "float, class:^thunar$,title:^(File Operation Progress)$"
        "float, class:^org.kde.kdeconnect.*$"
        "float, class:^org.inkscape.Inkscape$,title:^(Measure Path|PDF Import Settings)$"
      ];

      misc = {
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

          # Laptop keys
          ",XF86MonBrightnessUp, exec, lightctl up"
          ",XF86MonBrightnessDown, exec, lightctl down"
          ",XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause"
          ",XF86AudioRaiseVolume, exec, volumectl -u up"
          ",XF86AudioLowerVolume, exec, volumectl -u down"
          ",XF86AudioMute, exec, volumectl -m toggle-mute"
          ",XF86Calculator, exec, ${lib.getExe pkgs.qalculate-gtk}"

          # Groups
          "$mainMod SHIFT, V, togglegroup"
          "$mainMod, N, changegroupactive, f"
          "$mainMod SHIFT, N, changegroupactive, b"

          # Hypdland misc
          "$mainMod SHIFT, R, exec, hyprctl reload"

          # Plugins
          "$mainMod SHIFT, B, exec, pypr toggle btm && hyprctl dispatch bringactivetotop"
          "$mainMod SHIFT, T, exec, pypr toggle term && hyprctl dispatch bringactivetotop"
          "$mainMod SHIFT, E, exec, pypr toggle yazi && hyprctl dispatch bringactivetotop"

          # Apps keybindings
          "$mainMod, Return, exec, ${lib.getExe pkgs.kitty}"
          "$mainMod, B, exec, ${lib.getExe pkgs.microsoft-edge}"
          "$mainMod, T, exec, ${lib.getExe pkgs.telegram-desktop}"
          "$mainMod, N, exec, nm-connection-editor"
          "$mainMod, U, exec, blueman-manager"
          "$mainMod, E, exec, ${lib.getExe pkgs.gnome.nautilus}"

          "$mainMod SHIFT, N, exec, swaync-client -t"

          # Scripts
          "$mainMod, R, exec, ${lib.getExe pkgs.rofi-wayland} -show drun"
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
