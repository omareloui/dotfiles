{
  writeShellApplication,
  cliphist,
  rofi-wayland,
  wl-clipboard,
}:
writeShellApplication {
  name = "cliphist_wrapper";
  runtimeInputs = [cliphist rofi-wayland wl-clipboard];
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
          echo -e "  ''${BOLD}Usage:''${END_BOLD}    $(basename "$0") ''${YELLOW}[''${GREEN}action''${YELLOW}]''${RESET}"
          echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Description:''${RESET}"
          echo -e ""
          echo -e "    ''${B_GRAY}Open cliphist in rofi.''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Args:''${RESET}"
          echo -e ""
          echo -e "    ''${BOLD}''${GREEN}action''${WHITE} ''${YELLOW}{''${BLUE}list''${YELLOW}|''${BLUE}delete''${YELLOW}|''${BLUE}wipe''${YELLOW}}''${RESET}"
          echo -e "      ''${BLUE}list''${RESET}     ''${B_RED}-''${RESET} Select an entry to paste."
          echo -e "      ''${BLUE}delete''${RESET}   ''${B_RED}-''${RESET} Select an entry to delete."
          echo -e "      ''${BLUE}wipe''${RESET}     ''${B_RED}-''${RESET} Wipe out all entries."
          echo -e ""
          echo -e "  ''${BOLD}Options:''${RESET}"
          echo -e ""
          echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}     ''${B_RED}-''${RESET} Show this help and exit."
          echo -e ""
          echo -e "  ''${BOLD}Examples:''${RESET}"
          echo -e ""
          echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${BLACK} # lists the entries''${RESET}"
          echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} delete"
          echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} wipe"
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

      rofi_conf="$HOME/.config/rofi/cliphist.rasi"

      case "$1" in
        list)
          cliphist list | rofi -dmenu -replace -config "$rofi_conf" | cliphist decode | wl-copy
          ;;
        delete)
          cliphist list | rofi -dmenu -replace -config "$rofi_conf" | cliphist delete
          ;;
        wipe)
          if [[ "$(echo -e "Clear\nCancel" | rofi -dmenu -config ~/.config/rofi/short.rasi)" == "Clear" ]] ; then
            cliphist wipe
          fi
          ;;
      esac
    '';
}
