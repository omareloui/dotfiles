{
  writeShellApplication,
  rclone,
}:
writeShellApplication {
  name = "cloud_backup";
  runtimeInputs = [rclone];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      version=1.0.0

      verbose=0
      debug=0
      dry=0

      LONGOPTS=verbose,help,dry-run,debug
      OPTIONS=vhn

      PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
      eval set -- "$PARSED"

      while true; do
        case "$1" in
        --debug)
          debug=1
          shift
          ;;
        -v | --verbose)
          ((verbose == 1)) && debug=1
          verbose=1
          shift
          ;;
        -n | --dry-run)
          dry=1
          shift
          ;;
        -h | --help)
          echo -e "  ''${BOLD}Usage:''${END_BOLD}    $(basename "$0") ''${YELLOW}[''${B_RED}options''${DARK_GRAY}...''${YELLOW}]''${RESET}"
          echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Description:''${RESET}"
          echo -e ""
          echo -e "    ''${B_GRAY}Backup my files (currently only the leather designs) to my Google Drive.''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Options:''${RESET}"
          echo -e ""
          echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}       ''${B_RED}-''${RESET} Show this help and exit."
          echo -e "    ''${BLUE}-v''${RESET}, ''${BLUE}--verbose''${RESET}    ''${B_RED}-''${RESET} Explain what is being done."
          echo -e "    ''${BLUE}-vv''${RESET}, ''${BLUE}--debug''${RESET}    ''${B_RED}-''${RESET} Run with debug mode."
          echo -e "    ''${BLUE}-n''${RESET}, ''${BLUE}--dry-run''${RESET}    ''${B_RED}-''${RESET} Run without taking any permanent effects."
          echo -e ""
          echo -e "  ''${BOLD}Examples:''${RESET}"
          echo -e ""
          echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} -nv"
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

      function p() {
        logger "$1"
        if ((verbose == 1)); then
          echo -e "$1"
        fi
      }

      function init {
        options=""
        _options=""
        ((verbose == 1 && debug != 1)) && _options+=v
        ((dry == 1)) && _options+=n
        ((debug == 1)) && _options+=vv

        [[ -n $_options ]] && options="-$_options"

        for f in "$MYHOME/leatherwork:leatherwork/patterns_and_designs" "$MYHOME/documents/passwords.kdbx:secrets"; do
          src="$(echo "$f" | cut -d: -f1)"
          dest="$(echo "$f" | cut -d: -f2)"

          ({
            rclone sync --progress $options "$src" "GDrive:$dest"
          } && p "''${GREEN}Success''${YELLOW}:''${RESET} done syncing ''${src} to GDrive:''${dest}.''${RESET}\n\n") || p "''${RED}Error''${YELLOW}:''${RESET} something went wrong while syncing ''${src}.''${RESET}\n\n"
        done
      }

      init
    '';
}
