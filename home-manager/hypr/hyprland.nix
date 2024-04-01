{
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

      exec-once = [
        # "~/.autostart"
        "${lib.getExe pkgs.waybar}"
        "${lib.getExe pkgs.hypridle}"
        "${lib.getExe pkgs.swww} init"
        # "nm-applet --indeicator"
        # "${lib.getExe pkgs.xorg.xhost} +SI:localuser:root"
        "${lib.getExe pkgs.swaynotificationcenter}"
      ];

      exec = [
        "avizo-service"
      ];

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

      # "device:epic mouse V1" = {sensitivity = -0.5;};

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
        "float, class:^org.kde.kdeconnect.*$"
        "float, class:^org.inkscape.Inkscape$,title:^(Measure Path|PDF Import Settings)$"
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

          "$mainMod, E, exec, ${lib.getExe pkgs.gnome.nautilus}"
          "$mainMod, R, exec, ${lib.getExe pkgs.rofi-wayland} -show drun"
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

          # Groups
          "$mainMod SHIFT, V, togglegroup"
          "$mainMod, N, changegroupactive, f"
          "$mainMod SHIFT, N, changegroupactive, b"

          # Laptop keys
          ",XF86MonBrightnessUp, exec, lightctl up"
          ",XF86MonBrightnessDown, exec, lightctl down"
          ",XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause"
          ",XF86AudioRaiseVolume, exec, volumectl -u up"
          ",XF86AudioLowerVolume, exec, volumectl -u down"
          ",XF86AudioMute, exec, volumectl -m toggle-mute"

          # misc
          "$mainMod, W, exec, ${lib.getExe pkgs.wallpaper}"
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
