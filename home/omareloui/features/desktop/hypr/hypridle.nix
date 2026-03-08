{
  lib,
  pkgs,
  ...
}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || ${lib.getExe pkgs.hyprlock} --grace 2";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 150; # 2.5 mins
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300; # 5min
          on-timeout = "hyprctl switchxkblayout at-translated-set-2-keyboard 0 && loginctl lock-session";
        }
        {
          timeout = 330; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # Screen off
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
        {
          timeout = 1800; # 30min
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
