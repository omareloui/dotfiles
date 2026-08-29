{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./binds.nix
    ./exec.nix
    ./monitors.nix
    ./window-rules.nix
  ];

  wayland.windowManager.hyprland = let
    substitutions = {
      "@WLOGOUT@" = lib.getExe pkgs.wlogout;
      "@PLAYERCTL@" = lib.getExe pkgs.playerctl;
      "@QALCULATE@" = lib.getExe pkgs.qalculate-gtk;
      "@KITTY@" = lib.getExe pkgs.kitty;
      "@ZJ_SESSIONS@" = lib.getExe pkgs.zj_sessions;
      "@TELEGRAM@" = lib.getExe pkgs.telegram-desktop;
      "@NAUTILUS@" = lib.getExe pkgs.nautilus;
      "@WALLPAPER@" = lib.getExe pkgs.wallpaper;
      "@INIT_BAR@" = lib.getExe pkgs.init_bar;
      "@SCREENSHOT@" = lib.getExe pkgs.screenshot;

      "@PYPRLAND@" = lib.getExe pkgs.pyprland;
      "@HYPRSHADE@" = lib.getExe pkgs.hyprshade;
      "@BATWARNING@" = lib.getExe pkgs.batwarning;
      "@ANYRUN_DAEMON_CMD@" =
        lib.optionalString config.programs.anyrun.enable
        ''hl.exec_cmd("${lib.getExe config.programs.anyrun.package} daemon")'';
      "@KEEPASSXC_CMD@" =
        lib.optionalString config.programs.keepassxc.enable
        ''hl.exec_cmd("${lib.getExe config.programs.keepassxc.package} --minimized")'';
      "@ANYRUN_LAYER_RULE@" =
        lib.optionalString config.programs.anyrun.enable
        ''hl.layer_rule({ match = { namespace = "anyrun" }, blur = true, ignore_alpha = 0 })'';
      "@SWAYOSD_LAYER_RULE@" =
        lib.optionalString config.services.swaync.enable
        ''hl.layer_rule({ match = { namespace = "swayosd" }, blur = true, ignore_alpha = 0 })'';
    };
    subst = name:
      lib.replaceStrings
      (builtins.attrNames substitutions)
      (builtins.attrValues substitutions)
      (builtins.readFile (./lua + "/${name}"));
  in {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    configType = "lua";

    extraLuaFiles = {
      "config" = ./lua/config.lua;
      "binds" = subst "binds.lua";
      "exec" = subst "exec.lua";
      "monitors" = ./lua/monitors.lua;
      "window-rules" = subst "window-rules.lua";
    };
  };
}
