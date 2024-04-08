{
  writeShellApplication,
  hyprshade,
}:
writeShellApplication {
  name = "shade";
  runtimeInputs = [hyprshade];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      version=1.0.0

      LONGOPTS=help
      OPTIONS=h

      PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
      eval set -- "$PARSED"

      while true; do
        case "$1" in
          -h | --help)
            echo -e ""
            echo -e "  ''${BOLD}Usage:''${END_BOLD}    ''${B_MAGENTA}$(basename "$0") ''${YELLOW}[''${B_RED}options''${DARK_GRAY}...''${YELLOW}]''${B_RED} ''${YELLOW}<''${GREEN}action''${YELLOW}>''${RESET}"
            echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Description:''${RESET}"
            echo -e ""
            echo -e "    ''${B_GRAY}Change the applied shader.''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Args:''${RESET}"
            echo -e ""
            echo -e "    ''${BOLD}''${GREEN}action''${WHITE} ''${YELLOW}{''${BLUE}list''${YELLOW}|''${BLUE}ls''${YELLOW}|''${BLUE}toggle''${YELLOW}|''${BLUE}default''${YELLOW}|''${BLUE}bluefilter''${YELLOW}|''${BLUE}invert''${YELLOW}|''${BLUE}off''${YELLOW}}''${RESET}"
            echo -e "      ''${BLUE}list''${YELLOW}|''${BLUE}ls''${RESET}           ''${B_RED}-''${RESET} List the available shaders."
            echo -e "      ''${BLUE}toggle''${RESET}            ''${B_RED}-''${RESET} Toggles between the default and the blue light filter shaders."
            echo -e "      ''${BLUE}default''${RESET}           ''${B_RED}-''${RESET} Applies the default shader (vibrance)."
            echo -e "      ''${BLUE}bluefilter''${RESET}        ''${B_RED}-''${RESET} Applies the blue light filter shader."
            echo -e "      ''${BLUE}invert''${RESET}            ''${B_RED}-''${RESET} Applies the invert colors shader."
            echo -e "      ''${BLUE}off''${RESET}               ''${B_RED}-''${RESET} Turns off any applied shader."
            echo -e ""
            echo -e "  ''${BOLD}Options:''${RESET}"
            echo -e ""
            echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}        ''${B_RED}-''${RESET} Show this help."
            echo -e ""
            echo -e "  ''${BOLD}Examples:''${RESET}"
            echo -e ""
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} list"
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} toggle"
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} off"
            echo -e ""
            exit 0
            ;;
          --)
            shift
            break
            ;;
          *)
            echo "Programming error"
            exit 3
            ;;
        esac
      done



      default="vibrance"
      blue_light_filter="blue-light-filter"
      invert="invert-colors"


      case $1 in
      toggle)
        curr=$(hyprshade current)
        if [[ $curr == "" || $curr == "$default" ]]; then
          hyprshade on "$blue_light_filter"
        else
          hyprshade on "$default"
        fi
        ;;
      bluefilter)
        hyprshade on "$blue_light_filter"
        ;;
      invert)
        hyprshade on "$invert"
        ;;
      default)
        hyprshade on "$default"
        ;;
      off)
        hyprshade off
        ;;
      list | ls)
        hyprshade list
        ;;
      *)
        echo -e "''${RED_BG}''${BOLD}''${BLACK}Error''${RESET} invalid action."
        echo -e "Run ''${YELLOW}\"''${B_MAGENTA}''${BOLD}$(basename "$0") --help''${RESET}''${YELLOW}\"''${RESET} for more information."
        exit 1
        ;;
      esac
    '';
}
