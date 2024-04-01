{
  writeShellApplication,
  swww,
  ffmpeg,
  imagemagick,
}:
writeShellApplication {
  name = "wallpaper";
  runtimeInputs = [swww ffmpeg imagemagick];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      version=2.0.0

      LONGOPTS=help
      OPTIONS=h

      PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
      eval set -- "$PARSED"

      while true; do
        case "$1" in
        -h | --help)
          echo -e ""
          echo -e "  ''${BOLD}Usage:''${END_BOLD}    $(basename "$0") ''${YELLOW}[''${B_RED}options''${DARK_GRAY}...''${YELLOW}]''${RESET} ''${YELLOW}[''${GREEN}wallpaper_path''${YELLOW}]''${RESET}"
          echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Description:''${RESET}"
          echo -e ""
          echo -e "    ''${B_GRAY}A script to update the wallpaper.''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Args:''${RESET}"
          echo -e ""
          echo -e "    ''${BOLD}''${GREEN}wallpaper_path''${WHITE} ''${YELLOW}{''${BLUE}file''${YELLOW}}''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Options:''${RESET}"
          echo -e ""
          echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}             ''${B_RED}-''${RESET} Show this help and exit."
          echo -e ""
          echo -e "  ''${BOLD}Examples:''${RESET}"
          echo -e ""
          echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET}"
          echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} \$WALLPAPERS_DIR/nixos.png"
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

      WALLPAPERS_DIR=''${WALLPAPERS_DIR:-''${MYHOME:-$HOME/myhome}/pictures/wallpapers/.loop_over}

      wp=''${1:-"$(fd '.*\.(png|jpe?g|gif)$' "$WALLPAPERS_DIR" -Itf -d1 | shuf --random-source=/dev/urandom -n 1)"}

      swww img "$wp" --transition-step=45 2>/dev/null

      wall_cache_dir="$HOME/.cache/wallpapers"

      basename=$(basename -- "$wp")
      ext="''${basename##*.}"
      filename="''${basename%.*}"

      src="$wall_cache_dir/blurred_$filename.png"
      curr_name="blurred_wallpaper.png"

      png_cache_file="$wall_cache_dir/$filename.png"

      [[ ! -d $wall_cache_dir ]] && mkdir "$wall_cache_dir"

      if [[ $ext != "png" && ! -f $png_cache_file ]]; then
        ffmpeg -i "$wp" "$png_cache_file"
        src="$png_cache_file"
      fi

      if [[ ! -f $src ]]; then
        convert "$wp" -blur 0x16 -channel RGBA "$src"
      fi

      cp -f "$src" "$wall_cache_dir/$curr_name"
    '';
}
