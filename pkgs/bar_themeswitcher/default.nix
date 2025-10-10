{
  writeShellApplication,
  rofi,
  findutils,
}:
writeShellApplication {
  name = "bar_themeswitcher";
  runtimeInputs = [rofi findutils];
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
            echo -e "  ''${BOLD}Usage:''${END_BOLD}    $(basename "$0") ''${YELLOW}<''${GREEN}action''${YELLOW}>''${RESET}"
            echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Description:''${RESET}"
            echo -e ""
            echo -e "    ''${B_GRAY}Change the system bar theme.''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Options:''${RESET}"
            echo -e ""
            echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}   ''${B_RED}-''${RESET} Show this help and exit."
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
            echo -e "''${RED}Error:''${RESET} Programming error"
            exit 3
          ;;
        esac
      done

      themes_path="$HOME/.config/waybar/themes"

      declare -a listThemes=()
      listNames=""

      sleep 0.2
      options=$(find "$themes_path" -maxdepth 2 -type d)
      for value in $options; do
        assets="$HOME/.config/waybar/themes/assets"
        is_final_depth="$(find "$value" -maxdepth 1 -type d | wc -l)"
        if [[ ! "$value" == "$assets" && ! $value == "$themes_path" && "$is_final_depth" == 1 ]]; then
          # shellcheck disable=SC2001
          result="$(echo "$value" | sed "s;$HOME/.config/waybar/themes;;g")"
          IFS='/' read -ra arrThemes <<<"$result"
          listThemes[''${#listThemes[@]}]="/''${arrThemes[1]};$result"
          # listNames+="$(echo "$result" | sed -e 's;/\(\w\); \U\1;g' -e 's;^ ;;')\n"
          listNames+="$(echo "$result" | sed -e 's;/\(\w\); \1;g' -e 's;^ ;;')\n"
        fi
      done

      listNames=''${listNames::-2}

      choice=$(echo -e "$listNames" | rofi -dmenu -replace -i -no-show-icons -width 30 -p "Themes" -format i)

      if [[ "$choice" ]]; then
        echo "Loading waybar theme..."
        echo "''${listThemes[$choice]}" >~/.cache/.themestyle.sh
        init_bar
      fi
    '';
}
