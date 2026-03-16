{config, ...}: {
  programs.hyprlock = {
    enable = true;

    settings = {
      source = "~/.config/hypr/hyprlock/colors.conf";

      background = {
        monitor = "";
        path = "${config.home.homeDirectory}/.cache/wallpapers/current.png";
        blur_size = 6;
        blur_passes = 2;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      input-field = [
        {
          monitor = "";
          size = "250, 50";
          outline_thickness = 2;
          dots_size = 0.1;
          dots_spacing = 0.3;
          outer_color = "$entry_border_color";
          inner_color = "$entry_background_color";
          font_color = "$entry_color";
          fade_on_empty = true;

          position = "0, 20";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "$LAYOUT";
          color = "$text_color";
          font_size = 14;
          font_family = "$font_family";
          position = "-30, 30";
          halign = "right";
          valign = "bottom";
        }
        {
          # Caps Lock Warning
          monitor = "";
          text = "cmd[update:250] \${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprlock/check-capslock.sh";
          color = "$text_color";
          font_size = 13;
          font_family = "$font_family";
          position = "0, -25";
          halign = "center";
          valign = "center";
        }
        {
          # Clock;
          monitor = "";
          text = "$TIME";
          color = "$text_color";
          font_size = 65;
          font_family = "$font_family_clock";

          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          # Date;
          monitor = "";
          text = "cmd[update:5000] date +\"%A, %B %d\"";
          color = "$text_color";
          font_size = 17;
          font_family = "$font_family_clock";

          position = "0, 240";
          halign = "center";
          valign = "center";
        }
        {
          # User
          monitor = "";
          text = "    $USER";
          color = "$text_color";
          font_size = 20;
          font_family = "$font_family";
          position = "0, 50";
          halign = "center";
          valign = "bottom";
        }
        {
          # Status
          monitor = "";
          text = "cmd[update:5000] \${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprlock/status.sh";
          color = "$text_color";
          font_size = 14;
          font_family = "$font_family";

          position = "30, -30";
          halign = "left";
          valign = "top";
        }
      ];
    };
  };

  home.file = {
    ".config/hypr/hyprlock/status.sh".source = ./status.sh;
    ".config/hypr/hyprlock/check-capslock.sh".source = ./check-capslock.sh;
    ".config/hypr/hyprlock/colors.conf".source = ./colors.conf;
  };

  catppuccin.hyprlock.enable = false;
}
