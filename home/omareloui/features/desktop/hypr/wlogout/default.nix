{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "${lib.getExe pkgs.hyprlock} --grace 2";
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
  };

  home.file.".config/wlogout/icons" = {
    source = ./icons;
    recursive = true;
  };

  catppuccin.wlogout.extraStyle = ''
    window {
      background: url("${config.home.homeDirectory}/.cache/wallpapers/current_blurred.png");
      background-size: cover;
      background-position: center;
    }

    button {
      font-size:20px;
      border-radius: 10px;
      margin: 20px;
    }
  '';
}
