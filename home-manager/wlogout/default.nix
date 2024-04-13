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
    style = let
      p = config.colorScheme.palette;
    in
      /*
      css
      */
      ''
        @define-color foreground #${p.base05};
        @define-color background #${p.base00};
        @define-color cursor #${p.base05};

        @define-color color0  #${p.base00};
        @define-color color1  #${p.base01};
        @define-color color2  #${p.base02};
        @define-color color3  #${p.base03};
        @define-color color4  #${p.base04};
        @define-color color5  #${p.base05};
        @define-color color6  #${p.base06};
        @define-color color7  #${p.base07};
        @define-color color8  #${p.base08};
        @define-color color9  #${p.base09};
        @define-color color10 #${p.base0A};
        @define-color color11 #${p.base0B};
        @define-color color12 #${p.base0C};
        @define-color color13 #${p.base0D};
        @define-color color14 #${p.base0E};
        @define-color color15 #${p.base0F};

        /* -----------------------------------------------------
         * General
         * ----------------------------------------------------- */

        * {
          font-family: "Fira Sans Semibold", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          background-image: none;
          transition: 20ms;
          box-shadow: none;
        }

        window {
          background: url("${config.home.homeDirectory}/.cache/wallpapers/current_blurred.png");
          background-size: cover;
          background-position: center;
        }

        button {
          color: #FFFFFF;
          font-size:20px;

          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;

          border-style: solid;
          background-color: rgba(12, 12, 12, 0.3);
          /* border: 3px solid #FFFFFF; */
          border: 0px solid #FFFFFF;

          box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        }

        button:focus,
        button:active,
        button:hover {
          color: @color13;
          background-color: rgba(12, 12, 12, 0.5);
          border: 0px solid @color13;
          outline: none;
        }

        /*
        -----------------------------------------------------
        Buttons
        -----------------------------------------------------
        */

        #lock {
          margin: 10px;
          border-radius: 20px;
          background-image: image(url("icons/lock.png"));
        }

        #logout {
          margin: 10px;
          border-radius: 20px;
          background-image: image(url("icons/logout.png"));
        }

        #suspend {
          margin: 10px;
          border-radius: 20px;
          background-image: image(url("icons/suspend.png"));
        }

        #hibernate {
          margin: 10px;
          border-radius: 20px;
          background-image: image(url("icons/hibernate.png"));
        }

        #shutdown {
          margin: 10px;
          border-radius: 20px;
          background-image: image(url("icons/shutdown.png"));
        }

        #reboot {
          margin: 10px;
          border-radius: 20px;
          background-image: image(url("icons/reboot.png"));
        }
      '';
  };

  home.file.".config/wlogout/icons" = {
    source = ./icons;
    recursive = true;
  };
}
