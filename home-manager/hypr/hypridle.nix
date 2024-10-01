{pkgs, ...}: {
  home.packages = with pkgs; [
    hypridle
  ];

  home.file.".config/hypr/hypridle.conf".text =
    /*
    hyprlang
    */
    ''
      general {
          ignore_dbus_inhibit = false
      }

      # Screenlock
      listener {
          timeout = 600
          on-timeout = hyprctl switchxkblayout at-translated-set-2-keyboard 0 && hyprlock
      }

      # dpms
      listener {
          timeout = 660
          on-timeout = hyprctl dispatch dpms off
          on-resume = hyprctl dispatch dpms on
      }

      # Suspend
      listener {
          timeout = 1800
          on-timeout = systemctl suspend
      }
    '';
}
