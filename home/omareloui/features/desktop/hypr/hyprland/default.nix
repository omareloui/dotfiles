{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./binds.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      monitor = "eDP-1, preferred, auto, 1.6";
      workspace = "1, monitor:eDP-1, default:true";

      general = {
        gaps_in = 5;
        gaps_out = 14;
        border_size = 2;
        "col.active_border" = "rgba(fab387ee) rgba(cba6f7ee) 120deg";
        "col.inactive_border" = "rgba(1e1e2eaa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      input = {
        kb_layout = "us,es,eg";
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
        # inactive_opacity = 0.85;
        fullscreen_opacity = 1.0;

        shadow = {
          enabled = true;
          color = "0x66000000";
          range = 4;
          render_power = 3;
        };
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

      gesture = [
        "3, horizontal, workspace"
      ];

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
        "${lib.getExe pkgs.swaynotificationcenter}"
        "${lib.getExe pkgs.init_bar}"
        "${lib.getExe pkgs.hyprshade} auto"
      ];

      exec-once = [
        "${lib.getExe pkgs.hypridle}"
        "${lib.getExe pkgs.pyprland}"
        "${lib.getExe pkgs.xorg.xhost} +SI:${config.home.username}:root" # fixes the bluetooth stutter
        "${lib.getExe pkgs.telegram-desktop} -startintray"

        "wl-paste --watch cliphist store"

        "dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE"
      ];

      windowrulev2 = let
        shouldFloatClasses = "transmission-gtk|org\.gnome\.Loupe|pavucontrol|scratchpad|nm-connection-editor|org\.keepassxc\.KeePassXC";
        scratchpad = "class:^scratchpad-";
        bluetoothClientRe = "^\.blueman-manager-wrapped$";
        fileSelectorTitleRe = "^(Select file to open)$";
        fileSelectorClassRe = "^(xdg-desktop-portal-gtk)$";
        pipRe = "Picture[\- ]in[\- ][Pp]icture";
      in [
        "workspace special silent, ${scratchpad}"
        "stayfocused, ${scratchpad}"

        "float, class:^(${shouldFloatClasses})$"
        "center 1, class:^(${shouldFloatClasses})$"

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

        "opacity 0.95 0.95, class:^(microsoft-edge|zen-beta)$"
        "opacity 0.95 0.8, class:^(kitty|org\.wezfurlong\.wezterm)$"
        "opacity 0.85 0.8, class:^(org.gnome.Nautilus)$"

        "opacity 1 1, title:^(${pipRe})$"
        "pin, title:^(${pipRe})$"
        "float, title:^(${pipRe})$"
        "size 656 386, title:^(${pipRe})$"
        "move 1252 680, title:^(${pipRe})$"
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
    };
  };
}
