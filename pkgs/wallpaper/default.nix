{
  writeShellApplication,
  swww,
  ffmpeg,
  file,
  pywal,
}:
writeShellApplication {
  name = "wallpaper";
  runtimeInputs = [swww ffmpeg pywal file];
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

      # Set the image

      # transition_type="wipe"
      # transition_type="outer"
      # transition_type="random"

      # --transition-type="$transition_type" \
      swww img "$wp" \
        --transition-step=20 \
        --transition-bezier .43,1.19,1,.4 \
        --transition-fps=60 \
        --transition-duration=0.4 \
        --transition-pos "$(hyprctl cursorpos)"

      # Cache the png version of the image (for hyprlock)
      wall_cache_dir="$HOME/.cache/wallpapers"

      basename=$(basename -- "$wp")
      filename="''${basename%.*}"
      mime="$(file -b --mime-type "$wp" | cut -d '/' -f2)"

      png_cache_file="$wall_cache_dir/$filename.png"

      [[ ! -d $wall_cache_dir ]] && mkdir "$wall_cache_dir"

      if [[ $mime != "png" && ! -f $png_cache_file ]]; then
        ffmpeg -i "$wp" "$png_cache_file"
      elif [[ ! -f $png_cache_file  ]]; then
        png_cache_file="$wp"
      fi
      cp -f "$png_cache_file" "$wall_cache_dir/current.png"

      # Generate the blurry version
      blurry_cache_file="$wall_cache_dir/blurred_$filename.png"

      if [[ ! -f $blurry_cache_file ]]; then
        convert "$wp" -blur 0x16 -channel RGBA "$blurry_cache_file"
      fi

      cp -f "$blurry_cache_file" "$wall_cache_dir/current_blurred.png"

      # Generate the wallpaper colorscheme
      # wal -nqstei "$wp"
    '';
}
