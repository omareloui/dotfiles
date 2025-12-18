{
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bind = let
      workspaces = builtins.genList (x: builtins.toString (x + 1)) 9;
      directions = rec {
        left = "l";
        right = "r";
        up = "u";
        down = "d";
        h = left;
        l = right;
        k = up;
        j = down;
      };
    in
      [
        # window manipulation
        "$mod, escape, exec, ${lib.getExe pkgs.wlogout} -b 5 -T 400 -B 400"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen,"
        "$mod, C, pseudo, dwindle"

        "$mod, apostrophe, workspace, previous"
        "$mod SHIFT, apostrophe, workspace, next"

        # Resize in workspace
        "$mod CONTROL, h, splitratio, -0.1"
        "$mod CONTROL, l, splitratio, +0.1"

        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Layout
        "$mod CTRL, Space, togglefloating"

        # Groups
        # "$mod SHIFT, V, togglegroup"
        # "$mod, N, changegroupactive, f"
        # "$mod SHIFT, N, changegroupactive, b"

        # Hypdland misc
        "$mod SHIFT, R, exec, hyprctl reload"

        # Laptop keys
        ",XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause"
        ",XF86Calculator, exec, ${lib.getExe pkgs.qalculate-gtk}"

        # ",XF86MonBrightnessUp, exec, lightctl up"
        # ",XF86MonBrightnessDown, exec, lightctl down"

        # ",XF86AudioRaiseVolume, exec, volumectl -u up"
        # ",XF86AudioLowerVolume, exec, volumectl -u down"
        # ",XF86AudioMute, exec, volumectl toggle-mute"

        "$mod, A, exec, hyprctl switchxkblayout"

        # Plugins
        "$mod SHIFT, B, exec, pypr toggle btm && hyprctl dispatch bringactivetotop"
        "$mod SHIFT, T, exec, pypr toggle term && hyprctl dispatch bringactivetotop"
        "$mod SHIFT, E, exec, pypr toggle yazi && hyprctl dispatch bringactivetotop"

        # Apps keybindings
        "$mod, Return, exec, ${lib.getExe pkgs.kitty}"
        "$mod SHIFT, Return, exec, ${lib.getExe pkgs.zj_sessions}"
        "$mod, B, exec, [workspace 1] zen"
        "$mod, T, exec, ${lib.getExe pkgs.telegram-desktop}"
        "$mod, N, exec, nm-connection-editor"
        "$mod, U, exec, blueman-manager"
        "$mod, E, exec, ${lib.getExe pkgs.nautilus}"

        "$mod SHIFT, N, exec, swaync-client -t"

        # Scripts
        "$mod, R, exec, ${lib.getExe pkgs.rofi} -show drun"
        # "$mod, R, exec, ${lib.getExe inputs.anyrun.packages.${pkgs.stdenv.hostPlatform.system}.anyrun}"
        "$mod, V, exec, ${lib.getExe pkgs.cliphist_wrapper} list"

        "$mod, W, exec, ${lib.getExe pkgs.wallpaper}"

        "$mod CTRL SHIFT, R, exec, ${lib.getExe pkgs.init_bar}"

        ", Print, exec, ${lib.getExe pkgs.screenshot} -s 3 full"
        "$mod, Print, exec, ${lib.getExe pkgs.screenshot} -p area"

        "$mod, S, togglesplit"
        # "$mod SHIFT, space, togglefloating"

        # "$mod, minus, splitratio, -0.25"
        # "$mod SHIFT, minus, splitratio, -0.3333333"

        # "$mod, equal, splitratio, 0.25"
        # "$mod SHIFT, equal, splitratio, 0.3333333"

        # "$mod, U, togglespecialworkspace"
        # "$mod SHIFT, U, movetoworkspacesilent, special"
        # "$mod, I, pseudo"
      ]
      ++
      # Change workspace
      (builtins.map (n: "$mod, ${n}, workspace, ${n}") workspaces)
      ++
      # Move window to workspace
      (builtins.map (n: "$mod SHIFT, ${n}, movetoworkspace, ${n}") workspaces)
      ++
      # Move focus
      (lib.mapAttrsToList (key: direction: "$mod, ${key}, movefocus, ${direction}") directions)
      ++
      # Swap windows
      (lib.mapAttrsToList (key: direction: "$mod SHIFT, ${key}, swapwindow, ${direction}") directions)
      ++
      # Move windows
      (lib.mapAttrsToList (key: direction: "$mod CONTROL, ${key}, movewindow, ${direction}") directions)
      ++
      # Move monitor focus
      (lib.mapAttrsToList (key: direction: "$mod ALT, ${key}, focusmonitor, ${direction}") directions)
      ++
      # Move workspace to other monitor
      (lib.mapAttrsToList (key: direction: "$mod ALT SHIFT, ${key}, movecurrentworkspacetomonitor, ${direction}") directions);
  };
}
