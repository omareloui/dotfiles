{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
  };
  home.file.".config/waybar/modules.json".text = builtins.toJSON {
    # Workspaces
    "hyprland/workspaces" = {
      on-click = "activate";
      active-only = false;
      all-outputs = true;
      format = "{}";
      format-icons = {
        urgent = "";
        active = "";
        default = "";
      };
      persistent-workspaces = {
        "*" = 5;
      };
    };

    # Taskbar
    "wlr/taskbar" = {
      format = "{icon}";
      icon-size = 14;
      tooltip-format = "{title}";
      on-click = "activate";
      on-click-middle = "close";
      ignore-list = ["scratchpad" "kitty" "Picture in picture"];
      app_ids-mapping = {
        firefoxdeveloperedition = "firefox-developer-edition";
      };
      rewrite = {
        "Firefox Web Browser" = "Firefox";
        "Foot Server" = "Terminal";
      };
    };

    # Hyprland Window
    "hyprland/window" = {
      rewrite = {
        "(.*) - Brave" = "$1";
        "(.*) - Chromium" = "$1";
        "(.*) - Brave Search" = "$1";
        "(.*) - Outlook" = "$1";
        "(.*) Microsoft Teams" = "$1";
      };
      separate-outputs = true;
    };

    # Empty
    "custom/empty" = {
      format = "";
    };

    # Cliphist
    "custom/cliphist" = {
      format = "";
      on-click = "sleep 0.1 && ${lib.getExe pkgs.cliphist_wrapper} list";
      on-click-right = "sleep 0.1 &&  ${lib.getExe pkgs.cliphist_wrapper} delete";
      on-click-middle = "sleep 0.1 && ${lib.getExe pkgs.cliphist_wrapper} wipe";
      tooltip = false;
    };

    # Wallpaper
    "custom/shade" = {
      format = "";
      # on-click = ''curr=$(${lib.getExe pkgs.hyprshade} current); if [[ $curr == "" ]]; then; ${lib.getExe pkgs.hyprshade} toggle; elif [[ $curr == 'blue-light-filter' ]]; then; ${lib.getExe pkgs.hyprshade} on vibrance; else; ${lib.getExe pkgs.hyprshade} on blue-light-filter; fi'';
      on-click = ''${lib.getExe pkgs.shade} toggle'';
      tooltip = false;
    };

    # Wallpaper
    "custom/wallpaper" = {
      format = "";
      on-click = lib.getExe pkgs.wallpaper;
      tooltip = false;
    };

    # Waybar Themes
    "custom/waybarthemes" = {
      format = "";
      on-click = lib.getExe pkgs.bar_themeswitcher;
      tooltip = false;
    };

    # Filemanager Launcher
    "custom/filemanager" = {
      format = "";
      on-click = lib.getExe pkgs.gnome.nautilus;
      tooltip = false;
    };

    # Browser Launcher
    "custom/browser" = {
      format = "";
      on-click = lib.getExe pkgs.microsoft-edge;
      tooltip = false;
    };

    # Calculator
    "custom/calculator" = {
      format = "";
      on-click = lib.getExe pkgs.qalculate-gtk;
      tooltip = false;
    };

    # Rofi Application Launcher
    "custom/appmenu" = {
      format = "";
      on-click = "sleep 0.2;rofi -show drun -replace";
      tooltip = false;
    };

    # Power Menu
    "custom/exit" = {
      format = "";
      on-click = "${lib.getExe pkgs.wlogout} -b 5 -T 400 -B 400";
      tooltip = false;
    };

    # System tray
    tray = {
      icon-size = 18;
      spacing = 10;
    };

    # Clock
    clock = {
      format = "{:%I:%M%p %a}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "{:%d %b, %Y}";
    };

    # System
    "custom/system" = {
      format = "";
      tooltip = false;
    };

    # CPU
    cpu = {
      format = "/ C {usage}% ";
      on-click = "${lib.getExe pkgs.kitty} ${lib.getExe pkgs.bottom}";
    };

    # Memory
    memory = {
      format = "/ M {}% ";
      on-click = "${lib.getExe pkgs.kitty} ${lib.getExe pkgs.bottom}";
    };

    # Harddisc space used
    disk = {
      interval = 30;
      format = "D {percentage_used}% ";
      path = "/";
      on-click = "${lib.getExe pkgs.kitty} ${lib.getExe pkgs.bottom}";
    };

    "hyprland/language" = {
      format = "{short}";
    };

    # Group Hardware
    "group/hardware" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 300;
        children-class = "not-memory";
        transition-left-to-right = false;
      };
      modules = ["custom/system" "disk" "cpu" "memory"];
    };

    # Group Settings
    "group/settings" = {
      orientation = "horizontal";
      modules = [
        # "custom/chatgpt"
        "custom/settings"
        "custom/waybarthemes"
        "custom/wallpaper"
      ];
    };

    # Group Quicklinks
    "group/quicklinks" = {
      orientation = "horizontal";
      modules = ["custom/browser" "custom/filemanager"];
    };

    # Network
    network = {
      format = "{ifname}";
      format-wifi = "   {signalStrength}%";
      format-ethernet = "  {ifname}";
      format-disconnected = "Disconnected";
      tooltip-format = " {ifname} via {gwaddri}";
      tooltip-format-wifi = "   {ifname} @ {essid}\nIP = {ipaddr}\nStrength = {signalStrength}%\nFreq = {frequency}MHz\nUp = {bandwidthUpBits} Down = {bandwidthDownBits}";
      tooltip-format-ethernet = " {ifname}\nIP = {ipaddr}\n up = {bandwidthUpBits} down = {bandwidthDownBits}";
      tooltip-format-disconnected = "Disconnected";
      max-length = 50;
      on-click = "nm-connection-editor";
    };

    # Battery
    battery = {
      states = {
        # good = 95;
        warning = 30;
        critical = 15;
      };
      format = "{icon}   {capacity}%";
      format-charging = "  {capacity}%";
      format-plugged = "  {capacity}%";
      format-alt = "{icon}  {time}";
      # format-good = ""; // An empty format will hide the module
      # format-full = "";
      format-icons = [" " " " " " " " " "];
    };

    # Pulseaudio
    pulseaudio = {
      # scroll-step = 1; // %; can be a float
      format = "{icon}  {volume}%";
      format-bluetooth = "{volume}% {icon} {format_source}";
      format-bluetooth-muted = "󰝟  {icon} {format_source}";
      format-muted = "󰝟  {format_source}";
      format-source = "{volume}% ";
      format-source-muted = "";
      format-icons = {
        headphone = " ";
        hands-free = " ";
        headset = " ";
        phone = " ";
        portable = " ";
        car = " ";
        default = [" " " " " "];
      };
      on-click = "pavucontrol";
    };

    # Bluetooth
    bluetooth = {
      format = " {status}";
      format-disabled = "";
      format-off = "";
      interval = 30;
      on-click = "blueman-manager";
      format-no-controller = "";
    };

    # Other
    user = {
      format = "{user}";
      interval = 60;
      icon = false;
    };

    # Idle Inhibator
    idle_inhibitor = {
      format = "{icon}";
      tooltip = true;
      format-icons = {
        activated = "";
        deactivated = "";
      };
      on-click-right = lib.getExe pkgs.hyprlock;
    };
  };

  home.file.".config/waybar/themes" = {
    source = ./themes;
    recursive = true;
  };

  home.file.".config/waybar/palette.css".text = let
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
    '';
}
