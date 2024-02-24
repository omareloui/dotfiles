{
  writeShellApplication,
  dunst,
  brillo,
}:
writeShellApplication {
  name = "brightness";
  runtimeInputs = [dunst brillo];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      version=1.0.0

      declare action

      LONGOPTS=help
      OPTIONS=h


      PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
      eval set -- "$PARSED"

      while true; do
        case "$1" in
          -h | --help)
            echo -e ""
            echo -e "  ''${BOLD}Usage:''${END_BOLD}    $(basename "$0") ''${YELLOW}<''${GREEN}action''${YELLOW}>''${RESET}"
            echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Description:''${RESET}"
            echo -e ""
            echo -e "    ''${B_GRAY}Change the backlight brightness.''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Args:''${RESET}"
            echo -e ""
            echo -e "    ''${BOLD}''${GREEN}action''${WHITE} ''${YELLOW}{''${BLUE}up''${YELLOW}|''${BLUE}down''${YELLOW}|''${BLUE}mute''${YELLOW}}''${RESET}"
            echo -e "      ''${BLUE}up''${RESET}       ''${B_RED}-''${RESET} Change backlight brightness up."
            echo -e "      ''${BLUE}down''${RESET}     ''${B_RED}-''${RESET} Lower backlight brightness down."
            echo -e ""
            echo -e "  ''${BOLD}Options:''${RESET}"
            echo -e ""
            echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}   ''${B_RED}-''${RESET} Show this help and exit."
            echo -e ""
            echo -e "  ''${BOLD}Examples:''${RESET}"
            echo -e ""
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} up"
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} down"
            echo -e ""
            exit 0
          ;;
          --)
            action=$2
            shift 2
            break
          ;;
          *)
            echo -e "''${RED}Error:''${RESET} Programming error"
            exit 3
          ;;
        esac
      done

      NOTIF_ID=2592

      icons=(brightness-low brightness-medium brightness-high)

      function notify {
        brightness="$(awk -v n="$(light)" 'BEGIN{print int(n)}')"
        if ((brightness == 0)); then
          icon="brightness-off"
        else
          icon="''${icons[$(awk -v n="$(light)" 'BEGIN{print int(n/34)}')]}"
          [[ -z $icon ]] && icon="''${icons[3]}"
        fi
        dunstify -a "BRIGHTNESS" "Brightness" "$brightness %" -h int:value:"$brightness" -i "$HOME/.config/dunst/assets/ui/''${icon}.svg" -r "$NOTIF_ID" -u normal
      }

      case "$action" in
      up)
        brillo -u 150000 -A 10
        notify
        ;;
      down)
        brillo -u 150000 -U 10
        notify
        ;;
      esac
    '';
}
