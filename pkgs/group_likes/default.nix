{
  writeShellApplication,
  fd,
}:
writeShellApplication {
  name = "group_likes";
  runtimeInputs = [fd];
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
            echo -e "  ''${BOLD}Usage:''${END_BOLD}    ''${B_MAGENTA}$(basename "$0")''${RESET}"
            echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Description:''${RESET}"
            echo -e ""
            echo -e "    ''${B_GRAY}Move pictures (with suffix: '.*__\d{1,5}\.(png|jpe?g)') into a directory named after the prefix.''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Options:''${RESET}"
            echo -e ""
            echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}        ''${B_RED}-''${RESET} Show this help."
            echo -e ""
            echo -e "  ''${BOLD}Examples:''${RESET}"
            echo -e ""
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET}"
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

      for f in $(fd -d1 -tf -i '.*__(page)?(\d{1,5}|final)\w?\.(png|jpe?g|gif|webp)'); do
        # shellcheck disable=SC2001
        dir="$(echo "$f" | sed 's;__\(page\)\?\([0-9]\{1,5\}\|final\)[a-zA-z]\?\.\(jpe\?g\|png\|gif\|webp\);;i')"
        dir=$(echo "$dir" | tr '[:upper:]' '[:lower:]')
        mkdir -p "$dir"
        mv "$f" "$dir"
      done
    '';
}
