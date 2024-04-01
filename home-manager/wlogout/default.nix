{
  lib,
  pkgs,
  ...
}: {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = lib.getExe pkgs.hyprlock;
        text = "Lock (l)";
        keybind = "l";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot (r)";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown (s)";
        keybind = "s";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit 0";
        text = "Logout (e)";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend (u)";
        keybind = "u";
      }
    ];
    # style = ''
    #   window {
    #     background: #16191c;
    #   }
    #   button {
    #     color: #16191c;
    #   }
    # '';
  };
}
