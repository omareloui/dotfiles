{
  writeShellApplication,
  imagemagick,
  fd,
  busybox,
}:
writeShellApplication {
  name = "sortpics";
  runtimeInputs = [fd imagemagick busybox];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      version=1.0.0

      LONGOPTS=help,phone-dir:,desktop-dir:
      OPTIONS=h,p:,d:

      PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
      eval set -- "$PARSED"

      phone_dir="./phone"
      desk_dir="."

      while true; do
        case "$1" in
          -h | --help)
            echo -e ""
            echo -e "  ''${BOLD}Usage:''${END_BOLD}    ''${B_MAGENTA}$(basename "$0") ''${YELLOW}[''${B_RED}options''${DARK_GRAY}...''${YELLOW}]''${B_RED} ''${YELLOW}<''${GREEN}action''${YELLOW}>''${RESET}"
            echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Description:''${RESET}"
            echo -e ""
            echo -e "    ''${B_GRAY}Sort the pictures to acording to its size.''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Options:''${RESET}"
            echo -e ""
            echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}        ''${B_RED}-''${RESET} Show this help."
            echo -e "    ''${BLUE}-p''${RESET}, ''${BLUE}--phone-dir''${RESET}   ''${B_RED}-''${RESET} Set the phone sized images direcotry (\"$phone_dir\" is the default)."
            echo -e "    ''${BLUE}-d''${RESET}, ''${BLUE}--desktop-dir''${RESET} ''${B_RED}-''${RESET} Set the desktop sized images direcotry (\"$desk_dir\" is the default)."
            echo -e ""
            echo -e "  ''${BOLD}Examples:''${RESET}"
            echo -e ""
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET}"
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} -d ./desktop"
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} -d ./desk_pics -p ./phone_pics"
            echo -e ""
            exit 0
            ;;
          -d | --desktop-dir)
            shift
            desk_dir="$1"
            shift
            ;;
          -p | --phone-dir)
            shift
            phone_dir="$1"
            shift
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


      phone_dir="$(dirname "$phone_dir/img")"
      desk_dir="$(dirname "$desk_dir/img")"

      mkdir -p "$phone_dir" "$desk_dir"

      for f in $(fd -d1 -tf '\.(png|jpe?g)'); do
        is_for_phone="$(identify "$f" | awk '{print $3}' | awk -Fx '{if ($1+0 < $2+0) print "1"; else print "0"}')"
        if [[ $is_for_phone == 1 && $phone_dir != "." ]]; then
          mv "$f" "$phone_dir/$f"
        elif [[ $is_for_phone == 0 && $desk_dir != "." ]]; then
          mv "$f" "$desk_dir/$f"
        fi
      done
    '';
}
