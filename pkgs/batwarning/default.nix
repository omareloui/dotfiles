{
  acpi,
  ripgrep,
  libnotify,
  libcanberra-gtk3,
  writeShellApplication,
}:
writeShellApplication {
  name = "batwarning";
  runtimeInputs = [libnotify acpi ripgrep libcanberra-gtk3];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      version=2.0.0

      LONGOPTS=help,interval:
      OPTIONS=h,i:

      PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
      eval set -- "$PARSED"

      WARNING_LEVELS=(20 5 3)
      SUSPEND_ON=2
      CHARGED_ON=80

      interval=5

      while true; do
        case "$1" in
        -h | --help)
          echo -e ""
          echo -e "  ''${BOLD}Usage:''${END_BOLD}    $(basename "$0") ''${YELLOW}[''${B_RED}options''${DARK_GRAY}...''${YELLOW}]''${RESET}"
          echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Description:''${RESET}"
          echo -e ""
          echo -e "    ''${B_GRAY}Send a warning on defined battery levels.''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Options:''${RESET}"
          echo -e ""
          echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}       ''${B_RED}-''${RESET} Show this help and exit."
          echo -e "    ''${BLUE}-i''${RESET}, ''${BLUE}--interval''${RESET}   ''${B_RED}-''${RESET} Check status every x seconds. (default: $interval)"
          echo -e ""
          echo -e "  ''${BOLD}Examples:''${RESET}"
          echo -e ""
          echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET}"
          echo -e ""
          exit 0
          ;;
        i | interval)
          interval=$2
          shift 2
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

      BATTERY="Battery 0"

      BAT_CACHE_DIR=/tmp/battery
      LOW_NOTF_FILE="$BAT_CACHE_DIR/low"
      CHARGED_FILE="$BAT_CACHE_DIR/full"

      function check {
        [[ ! -d "$BAT_CACHE_DIR" ]] && mkdir "$BAT_CACHE_DIR"
        [[ ! -f "$LOW_NOTF_FILE" ]] && touch "$LOW_NOTF_FILE"

        current_percentage="$(acpi | awk "/$BATTERY/ {gsub(\"%\",\"\"); gsub(\",\",\"\"); print \$4}")"
        is_discharging="$(acpi | rg "$BATTERY" | rg -c "Discharging" || echo 0)"
        is_charging="$(acpi | rg "$BATTERY" | rg -c "Charging" || echo 1)"

        if ((is_charging==0 && current_percentage<=SUSPEND_ON)); then
          notify-send \
            "Going to sleep..." \
            "$current_percentage% of battery remaining." \
            -u critical \
            -i "battery" \
            -h "string:synchronous:battery"
          sleep 3
          systemd-run --user systemctl hybrid-sleep
        fi

        IFS=' ' read -r -a notified_for <<< "$(cat "$LOW_NOTF_FILE")"

        if
          [[ "$current_percentage" -ge "$CHARGED_ON" &&
            "$is_discharging" -eq 0 &&
            ! -f "$CHARGED_FILE" ]]
        then
          notify-send "Battery Charged" "$current_percentage% you can unplug the charger" \
            -i "battery-full-charging" \
            -h "string:synchronous:battery"
          # find in /run/current-system/sw/share/sounds
          canberra-gtk-play -i complete
          touch "$CHARGED_FILE"
        elif [[ "$is_discharging" -eq 1 && -f "$CHARGED_FILE" ]]; then
          rm "$CHARGED_FILE"
        fi

        # Warning on discharge
        for warning_level in "''${WARNING_LEVELS[@]}"; do
          should_notify=1
          for item in "''${notified_for[@]}"; do
            [[ "$warning_level" == "$item" ]] && should_notify=0
          done

          if [[ "$is_discharging" -eq 1 &&
            "$current_percentage" -le $warning_level &&
            $should_notify -eq 1 ]]; then
            notify-send "Low battery" "$current_percentage% of battery remaining" \
              -i "battery-empty" \
              -u critical \
              -h "string:synchronous:battery"
            canberra-gtk-play -i dialog-error --volume 25.0
            notified_for+=("$warning_level")
          fi
        done

        if [[ "$is_discharging" -eq 0 && "''${#notified_for[@]}" -gt 0 ]]; then
          notified_for=()
        fi

        echo "''${notified_for[*]}" >"$LOW_NOTF_FILE"
      }

      while true; do
        check
        sleep "$interval"
      done
    '';
}
