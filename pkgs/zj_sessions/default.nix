{
  writeShellApplication,
  fd,
  ripgrep,
  zellij,
  rofi-wayland,
}:
writeShellApplication {
  name = "zj_sessions";
  runtimeInputs = [fd zellij rofi-wayland ripgrep];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      version=1.0.1

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
            echo -e "    ''${B_GRAY}Start wezterm with a zellij session or attach to an already existing one.''${RESET}"
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


      _new='** new **'
      _named='** named **'

      _default_layout="compact"

      zj_session=$(
        zellij list-sessions 2>/dev/null |
          sed -e 's/\x1b\[[0-9;]*m//g' |
          rg -v 'EXITED -' |
          awk "BEGIN {print \"$_new\n$_named\"} {print \$1}" |
          rofi -dmenu
      )

      if [[ -z $zj_session ]]; then exit; fi

      function start_terminal_with_zj {
        # wezterm start -- zsh --login -c "$1"
        kitty --single-instance -e zsh -l -c "$1"
      }

      function start_default {
        start_terminal_with_zj "zellij --layout $_default_layout"
      }

      if [[ $zj_session == "$_new" ]]; then
        layouts=$(fd '.*' "$HOME/.config/zellij/layouts" | xargs -I{} -n1 basename {} .kdl)

        if [[ -z $layouts || $layouts == "$_default_layout" ]]; then
          start_default
          exit
        fi

        layout=$(echo "$layouts" | awk -F' ' "BEGIN {print \"$_default_layout\"} {print}" | rofi -dmenu -p "Select layout")
        if [[ -z $layout ]]; then exit; fi

        if [[ $layout == "$_default_layout" ]]; then
          start_default
        else
          start_terminal_with_zj "zellij --layout $layout attach -c $layout"
        fi
      elif [[ $zj_session == "$_named" ]]; then
        name=$(rofi -dmenu -p "Session name")
        if [[ -z $name ]]; then exit; fi
        start_terminal_with_zj "zellij attach -c $name"
      else
        start_terminal_with_zj "zellij attach -c $zj_session"
      fi
    '';
}
