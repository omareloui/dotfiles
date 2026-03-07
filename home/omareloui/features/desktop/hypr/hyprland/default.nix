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
      monitor = "eDP-1, preferred, auto, 1.5";
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
        (lib.mkIf config.programs.keepassxc.enable "${lib.getExe config.programs.keepassxc.package} --minimized")
      ];

      exec-once = [
        "${lib.getExe pkgs.hypridle}"
        "${lib.getExe pkgs.pyprland}"
        "${lib.getExe pkgs.xhost} +SI:${config.home.username}:root" # fixes the bluetooth stutter
        "${lib.getExe pkgs.telegram-desktop} -startintray"
        "${lib.getExe pkgs.init_bar}"
        "${lib.getExe pkgs.hyprshade} auto"
        "${lib.getExe pkgs.swaynotificationcenter}"

        "wl-paste --watch cliphist store"

        "dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE"
      ];

      windowrule = let
        shouldFloatClasses = "transmission-gtk|org\.gnome\.Loupe|pavucontrol|scratchpad|nm-connection-editor|org\.keepassxc\.KeePassXC";
        scratchpad = "match:class ^scratchpad-.*";
        bluetoothClientRe = "^\.blueman-manager-wrapped$";
        fileSelectorTitleRe = "^(Select file to open)$";
        fileSelectorClassRe = "^(xdg-desktop-portal-gtk)$";
        pipRe = "Picture[\- ]in[\- ][Pp]icture";
        ueberzugppRe = "match:class ^ueberzugpp_.*";
      in [
        "float on, ${ueberzugppRe}"
        "no_anim on, ${ueberzugppRe}"
        "no_focus on, ${ueberzugppRe}"
        "no_shadow on, ${ueberzugppRe}"
        "no_blur on, ${ueberzugppRe}"
        "border_size 0, ${ueberzugppRe}"
        "rounding 0, ${ueberzugppRe}"
        "size 800 800, ${ueberzugppRe}"

        "workspace special silent, ${scratchpad}"
        "stay_focused on, ${scratchpad}"

        "float on, match:class ^(${shouldFloatClasses})$"
        "center on, match:class ^(${shouldFloatClasses})$"

        "float on, match:class ${bluetoothClientRe}"
        "center on, match:class ${bluetoothClientRe}"
        "size 750 445, match:class ${bluetoothClientRe}"

        "float on, match:title ${fileSelectorTitleRe}"
        "center on, match:title ${fileSelectorTitleRe}"
        "size 1160 680, match:title ${fileSelectorTitleRe}"

        "float on, match:class ${fileSelectorClassRe}"
        "center on, match:class ${fileSelectorClassRe}"
        "size 1160 680, match:class ${fileSelectorClassRe}"

        "float on, match:class ^thunar$, match:title ^(File Operation Progress)$"
        "float on, match:class ^org.inkscape.Inkscape$, match:title ^(|Measure Path|PDF Import Settings|Calender|Frame|Offset Paths)$"

        "size 960 520, match:class ^transmission-gtk$, match:title ^Transmission$"
        "size 482 567, match:class ^transmission-gtk$, match:title ^Torrent Options$"

        "opacity 0.95 0.95, match:class ^(microsoft-edge|zen-beta)$"
        "opacity 0.95 0.8, match:class ^(kitty|org\.wezfurlong\.wezterm)$"
        "opacity 0.85 0.8, match:class ^(org.gnome.Nautilus)$"

        "opacity 1 1, match:title ^(${pipRe})$"
        "pin on, match:title ^(${pipRe})$"
        "float on, match:title ^(${pipRe})$"
        "size 656 386, match:title ^(${pipRe})$"
        "move 1137 733, match:title ^(${pipRe})$"
      ];

      layerrule = [
        "blur on, match:namespace rofi"
        "ignore_alpha 0, match:namespace rofi"

        "blur on, match:namespace waybar"

        "blur on, match:namespace wlogout"
        "blur on, match:class ^(swww)$"

        "blur on, match:namespace swaync-control-center"
        "blur on, match:namespace swaync-notification-window"
        "ignore_alpha 0, match:namespace swaync-control-center"
        "ignore_alpha 0, match:namespace swaync-notification-window"
      ];

      misc = {
        enable_swallow = true;
        swallow_regex = "^(Alacritty|kitty|wezterm|footclient|scratchpad)$";
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };
    };
  };
}
