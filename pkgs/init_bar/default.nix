{
  writeShellApplication,
  waybar,
}:
writeShellApplication {
  name = "init_bar";
  runtimeInputs = [waybar];
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
          echo -e "  ''${BOLD}Usage:''${END_BOLD}    $(basename "$0") ''${YELLOW}[''${B_RED}options''${DARK_GRAY}...''${YELLOW}]''${RESET}"
          echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Description:''${RESET}"
          echo -e ""
          echo -e "    ''${B_GRAY}Starts (or restarts if already open) the system bar.''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Options:''${RESET}"
          echo -e ""
          echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}     ''${B_RED}-''${RESET} Show this help and exit."
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

      # -----------------------------------------------------
      # Quit all running waybar instances
      # -----------------------------------------------------
      pkill waybar
      sleep 0.2

      # -----------------------------------------------------
      # Default theme: /THEMEFOLDER;/VARIATION
      # -----------------------------------------------------
      themestyle="/ml4w;/ml4w/light"

      # -----------------------------------------------------
      # Get current theme information from .cache/.themestyle.sh
      # -----------------------------------------------------
      if [[ -f "$HOME/.cache/.themestyle.sh" ]]; then
        themestyle=$(cat "$HOME/.cache/.themestyle.sh")
      else
        touch "$HOME/.cache/.themestyle.sh"
        echo "$themestyle" > "$HOME/.cache/.themestyle.sh"
      fi

      IFS=';' read -ra arrThemes <<<"$themestyle"
      echo "Theme: ''${arrThemes[0]}"

      if [[ ! -f "$HOME/.config/waybar/themes''${arrThemes[1]}/style.css" ]]; then
        themestyle="/ml4w;/ml4w/light"
      fi

      # -----------------------------------------------------
      # Loading the configuration
      # -----------------------------------------------------
      config_file="config"
      style_file="style.css"

      # Standard files can be overwritten with an existing config-custom or style-custom.css
      if [[ -f "$HOME/.config/waybar/themes''${arrThemes[0]}/config-custom" ]]; then
        config_file="config-custom"
      fi
      if [[ -f "$HOME/.config/waybar/themes''${arrThemes[1]}/style-custom.css" ]]; then
        style_file="style-custom.css"
      fi

      waybar -c "$HOME/.config/waybar/themes''${arrThemes[0]}/$config_file" -s "$HOME/.config/waybar/themes''${arrThemes[1]}/$style_file" &
    '';
}
