{
  writeShellApplication,
  dunst,
  acpi,
  ripgrep,
  libcanberra-gtk3,
}:
writeShellApplication {
  name = "batwarning";
  runtimeInputs = [dunst acpi ripgrep libcanberra-gtk3];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      ${import ./config.nix}


      version=2.0.0

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
          echo -e "    ''${B_GRAY}Send a warning on defined battery levels.''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Options:''${RESET}"
          echo -e ""
          echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}       ''${B_RED}-''${RESET} Show this help and exit."
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

      BAT_CACHE_DIR=/tmp/battery
      LOW_NOTF_FILE="$BAT_CACHE_DIR/low"
      CHARGED_FILE="$BAT_CACHE_DIR/full"

      [[ ! -d "$BAT_CACHE_DIR" ]] && mkdir "$BAT_CACHE_DIR"
      [[ ! -f "$LOW_NOTF_FILE" ]] && touch "$LOW_NOTF_FILE"

      current_percentage="$(acpi | rg 'Battery 1' | rg -o --pcre2 '[0-9]{1,3}(?=%)')"
      is_discharging="$(acpi | rg 'Battery 1' | rg -c "Discharging")"

      notified_for=$(cat "$LOW_NOTF_FILE")

      if
        [[ "$current_percentage" -ge "$CHARGED_ON" &&
          "$is_discharging" -eq 0 &&
          ! -f "$CHARGED_FILE" ]]
      then
        dunstify "Battery Charged" "$current_percentage% you can unplug the charger" \
          -i "$HOME/.local/share/icons/battery-charging.png" \
          -r "$NOTIFICATION_ID"
        canberra-gtk-play -i complete.oga
        touch "$CHARGED_FILE"
      elif [[ "$is_discharging" -eq 1 && -f "$CHARGED_FILE" ]]; then
        rm "$CHARGED_FILE"
      fi

      # Warning on discharge
      for warning_level in "''${WARNING_LEVELS[@]}"; do
        should_notify=1
        for item in $notified_for; do
          [[ "$warning_level" == "$item" ]] && should_notify=0
        done

        if [[ "$is_discharging" -eq 1 &&
          "$current_percentage" -le $warning_level &&
          $should_notify -eq 1 ]]; then
          dunstify "Low battery" "$current_percentage% of battery remaining" \
            -i "$HOME/.local/share/icons/battery-alert.png" \
            -u critical \
            -r "$NOTIFICATION_ID"
          canberra-gtk-play -i dialog-error --volume 25.0
          notified_for+=("$warning_level")
        fi
      done

      if [[ "$is_discharging" -eq 0 && "''${#notified_for[@]}" -gt 0 ]]; then
        notified_for=()
      fi

      echo "''${notified_for[*]}" >"$LOW_NOTF_FILE"
    '';
}
