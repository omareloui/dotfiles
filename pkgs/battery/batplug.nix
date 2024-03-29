{
  writeShellApplication,
  dunst,
  libcanberra-gtk3,
}:
writeShellApplication {
  name = "batplug";
  runtimeInputs = [dunst libcanberra-gtk3];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      ${import ./config.nix}

      version=1.0.0

      LONGOPTS=help
      OPTIONS=h

      PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
      eval set -- "$PARSED"

      while true; do
        case "$1" in
        -h | --help)
          echo -e ""
          echo -e "  ''${BOLD}Usage:''${END_BOLD}    $(basename "$0") ''${YELLOW}[''${B_RED}options''${DARK_GRAY}...''${YELLOW}]''${RESET} ''${YELLOW}<''${GREEN}action''${YELLOW}>''${RESET}"
          echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Description:''${RESET}"
          echo -e ""
          echo -e "    ''${B_GRAY}Send notification on connecting/disconnecting the power supply to/from the laptop (requires a udev rule to work automatically)''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Args:''${RESET}"
          echo -e ""
          echo -e "    ''${BOLD}''${GREEN}action''${WHITE} ''${YELLOW}{''${BLUE}connected''${YELLOW}|''${BLUE}disconnected''${YELLOW}}''${RESET}"
          echo -e "      ''${BLUE}connected''${RESET}      ''${B_RED}-''${RESET} Send a connected notification."
          echo -e "      ''${BLUE}disconnected''${RESET}   ''${B_RED}-''${RESET} Send a disconnected notification."
          echo -e ""
          echo -e "  ''${BOLD}Options:''${RESET}"
          echo -e ""
          echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}       ''${B_RED}-''${RESET} Show this help and exit."
          echo -e ""
          echo -e "  ''${BOLD}Examples:''${RESET}"
          echo -e ""
          echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} connected"
          echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} disconnected"
          echo -e ""
          exit 0
          ;;
        --)
          shift
          break
          ;;
        *)
          echo -e "''${RED}Error:''${RESET} Programming error"
          exit 3
          ;;
        esac
      done

      current_percentage=$(cat /sys/class/power_supply/BAT1/capacity)

      action=''${1:-invalid}

      case "$action" in
      connected)
        dunstify \
          "Charging" \
          "$current_percentage% of battery charged." \
          -i "$HOME/.local/share/icons/battery-charging.png" \
          -u normal \
          -r "$NOTIFICATION_ID"
        canberra-gtk-play -i power-plug
        ;;
      disconnected)
        dunstify \
          "Disconnected" \
          "$current_percentage% of battery remaining." \
          -i "$HOME/.local/share/icons/battery.png" \
          -u low \
          -r "$NOTIFICATION_ID"
        canberra-gtk-play -i power-unplug
        ;;
      *)
        echo -e "''${RED_BG}''${BLACK}Error''${YELLOW}:''${RESET} invalid option."
        echo -e "''${BOLD}''${CYAN}Eg''${YELLOW}:''${RESET} ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} connected"
        ;;
      esac
    '';
}
