{
  writeShellApplication,
  swaylock-effects,
}:
writeShellApplication {
  name = "slock";
  runtimeInputs = [swaylock-effects];
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
            echo -e "  ''${BOLD}Usage:''${END_BOLD}    $(basename "$0") ''${YELLOW}[''${B_RED}options''${DARK_GRAY}...''${YELLOW}]''${RESET}"
            echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Description:''${RESET}"
            echo -e ""
            echo -e "    ''${B_GRAY}Lock the current screen.''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Options:''${RESET}"
            echo -e ""
            echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}   ''${B_RED}-''${RESET} Show this help and exit."
            echo -e ""
            echo -e "  ''${BOLD}Examples:''${RESET}"
            echo -e ""
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET}"
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} -h"
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

      sleep 0.8

      swaylock \
        --screenshots \
        --clock \
        --timestr "%I:%M %P" \
        --datestr "" \
        \
        --indicator \
        --indicator-radius 50 \
        --indicator-thickness 3 \
        \
        --effect-blur 7x5 \
        --effect-vignette 0.5:0.5 \
        \
        --grace 2 \
        --fade-in 0.2
    '';

  # --text-color "$foreground" \
  # --text-clear-color "$yellow" \
  # --text-ver-color "$blue" \
  # --text-wrong-color "$red" \
  # \
  # --ring-clear-color "$yellow" \
  # --ring-ver-color "$blue" \
  # --ring-wrong-color "$red" \
  # --inside-clear-color "#00000000" \
  # --inside-ver-color "#00000000" \
  # --inside-wrong-color "#00000000" \
  # \
  # --bs-hl-color "$red" \
  # --caps-lock-key-hl-color "$red" \
  # --caps-lock-bs-hl-color "$red" \
  # \
  # --indicator-x-position 100 \
  # --indicator-y-position 1000 \
  # \
  # --ring-color "$foreground" \
  # --key-hl-color "$magenta" \
  # --line-color 00000000 \
  # --inside-color 00000000 \
  # --separator-color 00000000 \

  # indicator = false;
  # indicator-caps-lock = false;
  # indicator-radius = 60;
  # indicator-thickness = 5;

  # effect-blur = "12x12";
  # effect-vignette = "0.5:0.5";

  # line-color = "00000000";
  # line-clear-color = "00000000";
  # line-caps-lock-color = "00000000";
  # line-ver-color = "00000000";
  # line-wrong-color = "00000000";

  # ring-color = "00000033";
  # ring-caps-lock-color = "5500A3FF";
  # ring-wrong-color = "FF0000FF";

  # separator-color = "00000000";

  # text-color = "FFFFFFFF";
  # text-clear-color = "00000000";
  # text-wrong-color = "00000000";
  # text-ver-color = "00000000";
  # text-caps-lock-color = "00000000";

  # inside-color = "00000066";
  # inside-clear-color = "00000066";
  # inside-caps-lock-color = "00000066";
  # inside-ver-color = "00000066";
  # inside-wrong-color = "00000066";

  # grace = 5;
}
