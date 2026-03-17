{
  lib,
  pkgs,
  config,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    exec = [];

    exec-once = [
      "wl-paste --watch cliphist store"

      "${lib.getExe pkgs.pyprland}"
      "${lib.getExe pkgs.xhost} +SI:${config.home.username}:root" # fixes the bluetooth stutter
      "${lib.getExe pkgs.telegram-desktop} -startintray"
      "${lib.getExe pkgs.init_bar}"
      "${lib.getExe pkgs.hyprshade} auto"

      "${lib.getExe pkgs.batwarning}"

      (lib.mkIf config.programs.anyrun.enable "${lib.getExe config.programs.anyrun.package} daemon")
      (lib.mkIf config.programs.keepassxc.enable "${lib.getExe config.programs.keepassxc.package} --minimized")

      "dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE"
    ];
  };
}
