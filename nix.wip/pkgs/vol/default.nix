{writeShellApplication}:
writeShellApplication {
  name = "vol";
  runtimeInputs = [];
  text =
    /*
    bash
    */
    ''
      ${import ../ansi.nix}

      version=1.0.0

      steps=5
      declare action

      LONGOPTS=help,steps:
      OPTIONS=hs:


      PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
      eval set -- "$PARSED"

      while true; do
        case "$1" in
          -s | --steps)
          steps=$2
          shift 2
          ;;
          -h | --help)
            echo -e ""
            echo -e "  ''${BOLD}Usage:''${END_BOLD}    $(basename "$0") ''${YELLOW}<''${GREEN}action''${YELLOW}>''${RESET}"
            echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Description:''${RESET}"
            echo -e ""
            echo -e "    ''${B_GRAY}Change the volume.''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Args:''${RESET}"
            echo -e ""
            echo -e "    ''${BOLD}''${GREEN}action''${WHITE} ''${YELLOW}{''${BLUE}up''${YELLOW}|''${BLUE}down''${YELLOW}|''${BLUE}mute''${YELLOW}}''${RESET}"
            echo -e "      ''${BLUE}up''${RESET}       ''${B_RED}-''${RESET} Change the volume up by ''${BOLD}''${steps}%''${RESET}."
            echo -e "      ''${BLUE}down''${RESET}     ''${B_RED}-''${RESET} Lower the volume down by ''${BOLD}''${steps}%''${RESET}."
            echo -e "      ''${BLUE}mute''${RESET}     ''${B_RED}-''${RESET} Mute sound."
            echo -e ""
            echo -e "  ''${BOLD}Options:''${RESET}"
            echo -e ""
            echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}   ''${B_RED}-''${RESET} Show this help and exit."
            echo -e "    ''${BLUE}-s''${RESET}, ''${BLUE}--steps''${RESET}  ''${B_RED}-''${RESET} Change the steps to move by."
            echo -e ""
            echo -e "  ''${BOLD}Examples:''${RESET}"
            echo -e ""
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} up"
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} -s 10 down"
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

      function play_sound {
        canberra-gtk-play -i audio-volume-change -d "changevolume"
      }

      icons=(volume_low volume_medium volume_high)

      NOTF_ID=2593

      function notify {
        volume=$(amixer get Master | awk -F"[][]" '/Left:/ {print $2}' | sed 's/%//')
        volume_is_on=$(amixer get Master | awk -F"[][]" '/Left:/ {print $4}' | sed 's/%//')
        if [[ $volume_is_on == "off" ]]; then
          icon=volume_muted
        elif ((volume == 0)); then
          icon=volume_off
        else
          index="$(echo "($volume / 34)" | bc)"
          icon="''${icons[$index]}"
          [[ -z $icon ]] && icon="''${icons[2]}"
        fi
        dunstify \
          -a "VOLUME" \
          "Volume" \
          "$volume %" -h int:value:"$volume" \
          -i "$HOME/.config/dunst/assets/ui/''${icon}.svg" \
          -r $NOTF_ID \
          -u normal
      }

      case $action in
      up)
        amixer -D pipewire set Master unmute >/dev/null
        amixer -D pipewire set Master "$steps"%+ >/dev/null
        notify
        play_sound
        ;;
      down)
        amixer -D pipewire set Master unmute >/dev/null
        amixer -D pipewire set Master "$steps"%- >/dev/null
        notify
        play_sound
        ;;
      mute)
        amixer -D pipewire set Master toggle >/dev/null
        notify
        play_sound
        ;;
      esac
    '';
}
