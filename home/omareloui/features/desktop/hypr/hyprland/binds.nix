{
  lib,
  inputs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
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
        "$mainMod, escape, exec, ${lib.getExe pkgs.wlogout} -b 5 -T 400 -B 400"
        "$mainMod, Q, killactive,"
        "$mainMod, F, fullscreen,"
        "$mainMod, C, pseudo, dwindle"

        "$mainMod, tab, workspace, +1"
        "$mainMod SHIFT, tab, workspace, -1"

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
        "$mainMod, Return, exec, ${lib.getExe pkgs.kitty}"
        "$mainMod SHIFT, Return, exec, ${lib.getExe pkgs.zj_sessions}"
        "$mainMod, B, exec, [workspace 1] microsoft-edge"
        "$mainMod, T, exec, ${lib.getExe pkgs.telegram-desktop}"
        "$mainMod, N, exec, nm-connection-editor"
        "$mainMod, U, exec, blueman-manager"
        "$mainMod, E, exec, ${lib.getExe pkgs.nautilus}"

        "$mainMod SHIFT, N, exec, swaync-client -t"

        # Scripts
        # "$mainMod, R, exec, ${lib.getExe pkgs.rofi-wayland} -show drun"
        "$mainMod, R, exec, ${lib.getExe inputs.anyrun.packages.${pkgs.system}.anyrun}"
        "$mainMod, V, exec, ${lib.getExe pkgs.cliphist_wrapper} list"

        "$mainMod, W, exec, ${lib.getExe pkgs.wallpaper}"

        "$mainMod CTRL SHIFT, R, exec, ${lib.getExe pkgs.init_bar}"

        ", Print, exec, ${lib.getExe pkgs.screenshot} -s 3 full"
        "$mainMod, Print, exec, ${lib.getExe pkgs.screenshot} -p area"

        # "$mainMod SHIFT, Q, killactive"
        # "$mainMod SHIFT, E, exit"

        # "$mainMod, S, togglesplit"
        # "$mainMod, F, fullscreen, 1"
        # "$mainMod SHIFT, F, fullscreen, 0"
        # "$mainMod SHIFT, space, togglefloating"

        # "$mainMod, minus, splitratio, -0.25"
        # "$mainMod SHIFT, minus, splitratio, -0.3333333"

        # "$mainMod, equal, splitratio, 0.25"
        # "$mainMod SHIFT, equal, splitratio, 0.3333333"

        # "$mainMod, G, togglegroup"
        # "$mainMod, T, lockactivegroup, toggle"
        # "$mainMod, tab, changegroupactive, f"
        # "$mainMod SHIFT, tab, changegroupactive, b"

        # "$mainMod, apostrophe, workspace, previous"
        # "$mainMod SHIFT, apostrophe, workspace, next"
        # "$mainMod, dead_grave, workspace, previous"
        # "$mainMod SHIFT, dead_grave, workspace, next"

        # "$mainMod, U, togglespecialworkspace"
        # "$mainMod SHIFT, U, movetoworkspacesilent, special"
        # "$mainMod, I, pseudo"
      ]
      ++
      # Change workspace
      (builtins.map (n: "$mainMod, ${n}, workspace, ${n}") workspaces)
      ++
      # Move window to workspace
      (builtins.map (n: "$mainMod SHIFT, ${n}, movetoworkspacesilent, ${n}") workspaces)
      ++
      # Move focus
      (lib.mapAttrsToList (key: direction: "$mainMod, ${key}, movefocus, ${direction}") directions)
      ++
      # Swap windows
      (lib.mapAttrsToList (key: direction: "$mainMod SHIFT, ${key}, swapwindow, ${direction}") directions)
      ++
      # Move windows
      (lib.mapAttrsToList (key: direction: "$mainMod CONTROL, ${key}, movewindow, ${direction}") directions)
      ++
      # Move monitor focus
      (lib.mapAttrsToList (key: direction: "$mainMod ALT, ${key}, focusmonitor, ${direction}") directions)
      ++
      # Move workspace to other monitor
      (lib.mapAttrsToList (key: direction: "$mainMod ALT SHIFT, ${key}, movecurrentworkspacetomonitor, ${direction}") directions);
  };
}
