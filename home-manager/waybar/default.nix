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
      icon-size = 18;
      tooltip-format = "{title}";
      on-click = "activate";
      on-click-middle = "close";
      ignore-list = ["Alacritty"];
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

    # # ML4W Welcome App
    # "custom/ml4w-welcome" = {
    #   on-click = "~/dotfiles/apps/ML4W_Welcome-x86_64.AppImage";
    #   format = " ";
    #   tooltip = false;
    # };

    # Empty
    "custom/empty" = {
      format = "";
    };

    # # Youtube Subscriber Count
    # "custom/youtube" = {
    #   format = " {}";
    #   exec = "python ~/private/youtube.py";
    #   restart-interval = 600;
    #   on-click = "chromium https =#studio.youtube.com";
    #   tooltip = false;
    # };

    # Cliphist
    "custom/cliphist" = {
      format = "";
      on-click = "sleep 0.1 && ~/dotfiles/scripts/cliphist.sh";
      on-click-right = "sleep 0.1 && ~/dotfiles/scripts/cliphist.sh d";
      on-click-middle = "sleep 0.1 && ~/dotfiles/scripts/cliphist.sh w";
      tooltip = false;
    };

    # # Updates Count
    # "custom/updates" = {
    #   format = "  {}";
    #   tooltip-format = "{}";
    #   escape = true;
    #   return-type = "json";
    #   exec = "~/dotfiles/scripts/updates.sh";
    #   restart-interval = 60;
    #   on-click = "alacritty --class dotfiles-floating -e ~/dotfiles/scripts/installupdates.sh";
    #   on-click-right = "~/dotfiles/.settings/software.sh";
    #   tooltip = false;
    # };

    # Wallpaper
    "custom/wallpaper" = {
      format = "";
      on-click = "~/dotfiles/hypr/scripts/wallpaper.sh select";
      on-click-right = "~/dotfiles/hypr/scripts/wallpaper.sh";
      tooltip = false;
    };

    # Waybar Themes
    "custom/waybarthemes" = {
      format = "";
      on-click = "~/.config/waybar/themeswitcher.sh";
      tooltip = false;
    };

    # # Settings
    # "custom/settings" = {
    #   format = "";
    #   on-click = "~/dotfiles/apps/ML4W_Dotfiles_Settings-x86_64.AppImage";
    #   tooltip = false;
    # };

    # # Keybindings
    # "custom/keybindings" = {
    #   format = "";
    #   on-click = "~/dotfiles/hypr/scripts/keybindings.sh";
    #   tooltip = false;
    # };

    # Filemanager Launcher
    "custom/filemanager" = {
      format = "";
      on-click = lib.getExe pkgs.gnome.nautilus;
      tooltip = false;
    };

    # # Outlook Launcher
    # "custom/outlook" = {
    #   format = "";
    #   on-click = "chromium --app=https =#outlook.office.com/mail/";
    #   tooltip = false;
    # };

    # # Teams Launcher
    # "custom/teams" = {
    #   format = "";
    #   on-click = "chromium --app=https =#teams.microsoft.com/go";
    #   tooltip = false;
    # };

    # Browser Launcher
    "custom/browser" = {
      format = "";
      on-click = lib.getExe pkgs.microsoft-edge;
      tooltip = false;
    };

    # # ChatGPT Launcher
    # "custom/chatgpt" = {
    #   format = " ";
    #   on-click = "chromium --app=https =#chat.openai.com";
    #   tooltip = false;
    # };

    # Calculator
    "custom/calculator" = {
      format = "";
      on-click = lib.getExe pkgs.qalculate-gtk;
      tooltip = false;
    };

    # # Windows VM
    # "custom/windowsvm" = {
    #   format = "";
    #   on-click = "~/dotfiles/scripts/launchvm.sh";
    #   tooltip = false;
    # };

    # Rofi Application Launcher
    "custom/appmenu" = {
      format = "Apps";
      on-click = "sleep 0.2;rofi -show drun -replace";
      tooltip = false;
    };

    # # Rofi Application Launcher
    # "custom/appmenuicon" = {
    #   format = "";
    #   on-click = "rofi -show drun -replace";
    #   on-click-right = "~/dotfiles/hypr/scripts/keybindings.sh";
    #   tooltip = false;
    # };

    # Power Menu
    "custom/exit" = {
      format = "";
      on-click = lib.getExe pkgs.wlogout;
      tooltip = false;
    };

    # keyboard-state = {
    #   numlock = true;
    #   capslock = true;
    #   format = "{name} {icon}";
    #   format-icons = {
    #     locked = "";
    #     unlocked = "";
    #   };
    # };

    # System tray
    tray = {
      icon-size = 21;
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
      format = "/ K {short}";
    };

    # Group Hardware
    "group/hardware" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 300;
        children-class = "not-memory";
        transition-left-to-right = false;
      };
      modules = ["custom/system" "disk" "cpu" "memory" "hyprland/language"];
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
      tooltip-format-wifi = "  {ifname} @ {essid}\nIP = {ipaddr}\nStrength = {signalStrength}%\nFreq = {frequency}MHz\nUp = {bandwidthUpBits} Down = {bandwidthDownBits}";
      tooltip-format-ethernet = " {ifname}\nIP = {ipaddr}\n up = {bandwidthUpBits} down = {bandwidthDownBits}";
      tooltip-format-disconnected = "Disconnected";
      max-length = 50;
      on-click = "~/dotfiles/.settings/networkmanager.sh";
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
      format = "{icon} {volume}%";
      format-bluetooth = "{volume}% {icon} {format_source}";
      format-bluetooth-muted = " {icon} {format_source}";
      format-muted = " {format_source}";
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
