{...}: {
  imports = [
    ./binds.nix
    ./exec.nix
    ./window-rules.nix
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

      misc = {
        enable_swallow = true;
        swallow_regex = "^(Alacritty|kitty|wezterm|footclient|scratchpad)$";
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };
    };
  };
}
