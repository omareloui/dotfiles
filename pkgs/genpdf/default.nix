{
  writeShellApplication,
  ffmpeg,
  ghostscript,
  optimize,
  ...
}:
writeShellApplication {
  name = "genpdf";
  runtimeInputs = [ffmpeg ghostscript optimize];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      version=1.0.0

      custom_output=""

      function show_help {
        echo -e ""
        echo -e "''${BOLD}Usage:''${END_BOLD}    ''${B_MAGENTA}$(basename "$0") ''${YELLOW}[''${B_RED}options''${DARK_GRAY}...''${YELLOW}]''${B_RED} ''${YELLOW}<''${GREEN}media_file''${DARK_GRAY}...''${YELLOW}>''${RESET}"
        echo -e "''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
        echo -e ""
        echo -e "''${BOLD}Description:''${RESET}"
        echo -e ""
        echo -e "    ''${B_GRAY}Gernerate pdf file from a set of images.''${RESET}"
        echo -e ""
        echo -e "''${BOLD}Args:''${RESET}"
        echo -e ""
        echo -e "  ''${YELLOW}<''${GREEN}media_file''${DARK_GRAY}...''${YELLOW}>''${RESET}    ''${B_RED}-''${RESET} Images to generate the pdf with."
        echo -e ""
        echo -e "''${BOLD}Options:''${RESET}"
        echo -e ""
        echo -e "  ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}                ''${B_RED}-''${RESET} Show this help message."
        echo -e "  ''${BLUE}-o''${RESET}, ''${BLUE}--output''${RESET}              ''${B_RED}-''${RESET} Specify the output file."
        echo -e ""
        echo -e "''${BOLD}Examples:''${RESET}"
        echo -e ""
        echo -e "  ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} img1.png img2.jpg img3.webp"
        echo -e "  ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} *.{png,jpe?g,webp} ''${BLUE}-o''${RESET} output.pdf"
        echo -e ""
      }

      LONGOPTS=help,output:
      OPTIONS=ho:

      PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
      eval set -- "$PARSED"

      while true; do
        case "$1" in
          -h | --help)
            show_help
            exit 0
            ;;
          -o | --output)
            custom_output="$2"
            shift 2
            ;;
          --)
            shift
            break
            ;;
          *)
            echo "''${BOLD}''${RED}Unknown option''${YELLOW}:''${RESET} $1"
            show_help
            exit 3
            ;;
        esac
      done

      if [[ $# -eq 0 ]]; then
        echo "''${BOLD}''${RED}Error''${YELLOW}:''${RESET} No files provided."
        show_help
        exit 1
      fi

      out=".output.pdf"
      opt_out=".output.optimized.pdf"

      # shellcheck disable=SC2068
      magick convert $@ $out &&
        optimize -o "$opt_out" "$out"

      if [[ -f $opt_out ]]; then
        if [[ -n $custom_output ]]; then
          filename="$custom_output"
        else
          filename="$(basename "$(pwd)" | sed 's/ /_/g').pdf"
        fi

        mv $opt_out "$filename"
        rm -f $out
      fi
    '';
}
