{
  ffmpeg,
  writeShellApplication,
  bc,
  gifsicle,
  ...
}:
writeShellApplication {
  name = "gengif";
  runtimeInputs = [ffmpeg bc gifsicle];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      version=1.0.0

      LONGOPTS=help,width:,start-perc:,fps:,duration:,colors:,high,quality:,no-optimization,out-dir:
      OPTIONS=h,w:,p:,f:,d:,c:,H,q:,P,o:

      PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
      eval set -- "$PARSED"

      start_perc=0.25
      duration=8
      fps=10
      width=480
      max_colors=32
      quality=80

      width_on_horz=540

      out_dir=""

      custom_width=0
      high=0
      no_optimization=0

      while true; do
        case "$1" in
        -h | --help)
          echo -e ""
          echo -e "  ''${BOLD}Usage:''${END_BOLD}    ''${B_MAGENTA}$(basename "$0") ''${YELLOW}<''${GREEN}videos''${DARK_GRAY}...''${YELLOW}>''${RESET}"
          echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Description:''${RESET}"
          echo -e ""
          echo -e "    ''${B_GRAY}Generate preview gif from videos.''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Options:''${RESET}"
          echo -e ""
          echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}            ''${B_RED}-''${RESET} Show this help."
          echo -e "    ''${BLUE}-w''${RESET}, ''${BLUE}--width''${RESET}           ''${B_RED}-''${RESET} Set the width of the generated GIF. ''${DARK_GRAY}(default if horizontal video: $width_on_horz else: $width)''${RESET}"
          echo -e "    ''${BLUE}-p''${RESET}, ''${BLUE}--start-perc''${RESET}      ''${B_RED}-''${RESET} Set when to start the GIF. The value is a percentage of the video's run time. ''${DARK_GRAY}(default: $start_perc)''${RESET}"
          echo -e "    ''${BLUE}-f''${RESET}, ''${BLUE}--fps''${RESET}             ''${B_RED}-''${RESET} Set the fps of the GIF. ''${DARK_GRAY}(default: $fps)''${RESET}"
          echo -e "    ''${BLUE}-d''${RESET}, ''${BLUE}--duration''${RESET}        ''${B_RED}-''${RESET} Set the duration of the GIF. ''${DARK_GRAY}(default: $duration)''${RESET}"
          echo -e "    ''${BLUE}-c''${RESET}, ''${BLUE}--colors''${RESET}          ''${B_RED}-''${RESET} Set the max colors of the GIF. ''${DARK_GRAY}(default: $max_colors)''${RESET}"
          echo -e "    ''${BLUE}-q''${RESET}, ''${BLUE}--quality''${RESET}         ''${B_RED}-''${RESET} Set the quality of the GIF. ''${DARK_GRAY}(default: $quality)''${RESET}"
          echo -e "    ''${BLUE}-H''${RESET}, ''${BLUE}--high''${RESET}            ''${B_RED}-''${RESET} Preset with high quality options. ''${DARK_GRAY}(default: false)''${RESET}"
          echo -e "    ''${BLUE}-P''${RESET}, ''${BLUE}--no-optimization''${RESET} ''${B_RED}-''${RESET} Ignore optimizing the GIF. ''${DARK_GRAY}(default: false)''${RESET}"
          echo -e "    ''${BLUE}-o''${RESET}, ''${BLUE}--out-dir''${RESET}         ''${B_RED}-''${RESET} Out directory for generated file. ''${DARK_GRAY}(default the original files directory)''${RESET}"
          echo -e ""
          echo -e "  ''${BOLD}Examples:''${RESET}"
          echo -e ""
          echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0") ''${B_GRAY}file1.mp4 file2.mp4''${RESET}"
          echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0") -H ''${B_GRAY}file1.mp4''${RESET}"
          echo -e ""
          exit 0
          ;;
        -w | --width)
          custom_width=1
          width=$2
          shift 2
          ;;
        -p | --start-perc)
          start_perc=$2
          shift 2
          ;;
        -f | --fps)
          fps=$2
          shift 2
          ;;
        -d | --duration)
          duration=$2
          shift 2
          ;;
        -c | --colors)
          max_colors=$2
          shift 2
          ;;
        -q | --quality)
          quality=$2
          shift 2
          ;;
        -H | --high)
          high=1
          fps=20
          width=540
          max_colors=64
          quality=90
          shift
          ;;
        -P | --no-optimization)
          no_optimization=1
          shift
          ;;
        -o | --out-dir)
          out_dir=$2
          shift 2
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



      for i in "$@"; do

        vid="$i"
        dir=$(dirname -- "$vid")
        filename="$(basename -- "$vid")"
        filename="''${filename%.*}"

        len="$(ffprobe -i "$vid" -show_entries format=duration -v quiet -of csv="p=0")"
        start_time="$(echo "$len * $start_perc" | bc)"

        dimensions="$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$vid")"
        v_width="$(echo "$dimensions" | cut -dx -f1)"
        v_hight="$(echo "$dimensions" | cut -dx -f2)"

        tmp="/tmp/$filename.tmp.gif"

        if ((custom_width == 0 && v_hight < v_width)); then
          if ((high==1)); then
              width=720
          else
              width=$width_on_horz
          fi
        fi

        ffmpeg -v warning -ss "$start_time" -t "$duration" -i "$vid" \
          -filter_complex "fps=$fps,scale=$width:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=''${max_colors}[p];[s1][p]paletteuse=dither=bayer" \
          -y "$tmp"

        if [[ -n $out_dir ]]; then
          dir=$out_dir
        fi

        dst="$dir/$filename.gif"

        if ((no_optimization == 1)); then
          mv "$tmp" "$dst"
        else
          gifsicle -O1 --lossy="$quality" --resize-width="$width" --colors="$max_colors" "$tmp" -o "$dst"
          rm -rf "$tmp"
        fi

      done
    '';
}
