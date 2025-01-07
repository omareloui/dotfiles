{
  writeShellApplication,
  ffmpeg,
  ghostscript,
  ...
}:
writeShellApplication {
  name = "optimize";
  runtimeInputs = [ffmpeg ghostscript];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      version=1.1.0

      custom_output=""
      replace_original=false
      resize=false
      max_width=1920
      max_height=1080
      image_quality_factor=14
      verbose=true

      function show_help {
        echo -e ""
        echo -e "''${BOLD}Usage:''${END_BOLD}    ''${B_MAGENTA}$(basename "$0") ''${YELLOW}[''${B_RED}options''${DARK_GRAY}...''${YELLOW}]''${B_RED} ''${YELLOW}<''${GREEN}media_file''${DARK_GRAY}...''${YELLOW}>''${RESET}"
        echo -e "''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
        echo -e ""
        echo -e "''${BOLD}Description:''${RESET}"
        echo -e ""
        echo -e "    ''${B_GRAY}Optimizes images, videos, and pdf files.''${RESET}"
        echo -e ""
        echo -e "''${BOLD}Args:''${RESET}"
        echo -e ""
        echo -e "  ''${YELLOW}<''${GREEN}media_file''${DARK_GRAY}...''${YELLOW}>''${RESET}    ''${B_RED}-''${RESET} One or more image or video files to optimize."
        echo -e ""
        echo -e "''${BOLD}Options:''${RESET}"
        echo -e ""
        echo -e "  ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}                ''${B_RED}-''${RESET} Show this help message."
        echo -e "  ''${BLUE}-R''${RESET}, ''${BLUE}--resize''${RESET}              ''${B_RED}-''${RESET} Resize the image or video."
        echo -e "  ''${BLUE}-W''${RESET}, ''${BLUE}--max-width ''${YELLOW}<''${MAGENTA}int''${YELLOW}>''${RESET}     ''${B_RED}-''${RESET} When \`--resize\` is provided, set maximum width ''${DARK_GRAY}(default: $max_width)''${RESET}."
        echo -e "  ''${BLUE}-H''${RESET}, ''${BLUE}--max-height ''${YELLOW}<''${MAGENTA}int''${YELLOW}>''${RESET}    ''${B_RED}-''${RESET} When \`--resize\` is provided, set maximum height ''${DARK_GRAY}(default: $max_height)''${RESET}."
        echo -e "  ''${BLUE}-Q''${RESET}, ''${BLUE}--image-quality ''${YELLOW}<''${MAGENTA}int''${YELLOW}>''${RESET} ''${B_RED}-''${RESET} Set the image quality ''${DARK_GRAY}(highest: 0, lowest: 100, default: $image_quality_factor)''${RESET}."
        echo -e "  ''${BLUE}-r''${RESET}, ''${BLUE}--replace-original''${RESET}    ''${B_RED}-''${RESET} Replace original images with optimized ones."
        echo -e "  ''${BLUE}-o''${RESET}, ''${BLUE}--output''${RESET}              ''${B_RED}-''${RESET} Specify the output file."
        echo -e "  ''${BLUE}-q''${RESET}, ''${BLUE}--quite''${RESET}               ''${B_RED}-''${RESET} Make the command quiter."
        echo -e ""
        echo -e "''${BOLD}Examples:''${RESET}"
        echo -e ""
        echo -e "  ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} video1.mp4 img1.png"
        echo -e "  ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} -r img1.png"
        echo -e "  ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} -r -RH 720 video1.mp4"
        echo -e ""
      }

      LONGOPTS=help,max-width:,max-height:,replace-original,resize,image-quality:,output:,quite
      OPTIONS=hW:H:rRnQ:o:q

      PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
      eval set -- "$PARSED"

      while true; do
        case "$1" in
          -h | --help)
            show_help
            exit 0
            ;;
          -R | --resize)
            resize=true
            shift
            ;;
          -Q | --image-quality)
            image_quality_factor="$2"
            shift 2
            ;;
          -W | --max-width)
            max_width="$2"
            shift 2
            ;;
          -H | --max-height)
            max_height="$2"
            shift 2
            ;;
          -r | --replace-original)
            replace_original=true
            shift
            ;;
          -q | --quite)
            verbose=false
            shift
            ;;
          -o | --output)
            custom_output="$2"
            shift 2
            ;;
          --)
            shift
            break
            ;;
          *)
            echo "''${BOLD}''${RED}Unknown option''${YELLOW}:''${RESET} $1"
            show_help
            exit 3
            ;;
        esac
      done

      if [[ $# -eq 0 ]]; then
        echo "''${BOLD}''${RED}Error''${YELLOW}:''${RESET} No media files provided."
        show_help
        exit 1
      fi

      function optimize_jpeg {
        local file=$1
        local output=$2

        local scale_filter=""

        if $resize; then
          dimensions=$(identify -format "%w:%h" "$file")
          width=$(echo "$dimensions" | cut -d: -f1)
          height=$(echo "$dimensions" | cut -d: -f2)

          # Calculate the scaling factor to fit within the maximum dimensions
          scale_factor=$(echo "scale=2; $max_width/$width" | bc -l)
          if (( $(echo "$scale_factor > 1" | bc -l) )); then
            scale_factor=1
          fi
          scale_height=$(echo "scale=2; $max_height/$height" | bc -l)
          if (( $(echo "$scale_height > 1" | bc -l) )); then
            scale_height=1
          fi

          height_scale_is_smaller=$(echo "$scale_factor > $scale_height" | bc -l)
          if ((height_scale_is_smaller == 1)); then
            scale_factor="$scale_height"
          fi

          scale_filter="-vf "scale=''${scale_factor}:''${scale_factor}:force_original_aspect_ratio=decrease""
        fi

        # shellcheck disable=SC2086
        ffmpeg -y -loglevel error \
          -i "$file" \
          -q:v "$image_quality_factor" \
          $scale_filter \
          -map_metadata -1 \
          "$output"
      }

      function optimize_other_images {
        local scale_width=-1
        local scale_height=-1

        if $resize; then
          scale_width="$max_width"
          scale_height="$max_height"
        fi

        ffmpeg -y -loglevel error \
          -i "$1" \
          -compression_level 9 \
          -vf "scale=$scale_width:$scale_height:force_original_aspect_ratio=decrease" \
          -map_metadata -1 "$2"
      }

      function optimize_videos {
        scale_width=-1
        scale_height=-1

        if $resize; then
          scale_width="$max_width"
          scale_height="$max_height"
        fi

        ffmpeg -y -loglevel error \
          -i "$1" \
          -vf "scale=$scale_width:$scale_height:force_original_aspect_ratio=decrease" \
          -c:v libx264 \
          -crf 23 \
          -c:a aac \
          -b:a 128k \
          "$2"
      }

      function optimize_pdf {
        gs \
          -q \
          -dNOPAUSE \
          -dBATCH \
          -dSAFER \
          -sDEVICE=pdfwrite \
          -dNOTRANSPARENCY \
          -dPDFSETTINGS=/screen \
          -dEmbedAllFonts=true \
          -dSubsetFonts=true \
          -dColorImageDownsampleType=/Bicubic \
          -dColorImageResolution=144 \
          -dGrayImageDownsampleType=/Bicubic \
          -dGrayImageResolution=144 \
          -dMonoImageDownsampleType=/Bicubic \
          -dMonoImageResolution=144 \
          -sOutputFile="$2" \
          "$1"
      }


      for file in "$@"; do
        if [[ ! -f "$file" ]]; then
           echo -e "''${BOLD}''${RED}Error''${YELLOW}:''${RESET} File not found: ''${BOLD}''${DARK_GRAY}$file''${RESET}."
           continue
        fi

        ext="''${file##*.}"
        ext="''${ext,,}"  # Convert to lowercase

        output="$custom_output"

        if [[ -z $custom_output ]]; then
          output="''${file%.*}.optimized.$ext"
        fi

        if $verbose; then
          echo -e "''${BLUE}''${BOLD}Processing''${YELLOW}:''${RESET} $file"
        fi

        case "$ext" in
        "pdf")
          optimize_pdf "$file" "$output"
          ;;
        "jpg"|"jpeg")
          optimize_jpeg "$file" "$output"
          ;;
        "png"|"webp"|"gif")
          optimize_other_images "$file" "$output"
          ;;
        "mp4"|"avi"|"mov"|"mkv")
          optimize_videos "$file" "$output"
          ;;
        *)
          echo -e "''${BOLD}''${YELLOW}Warning''${RED}:''${RESET} Unsupported file type: ''${BOLD}$file''${RESET}."
          continue
          ;;
        esac

        # shellcheck disable=SC2181
        if [[ $? -eq 0 ]]; then
          if $verbose; then
            original_size=$(stat -c %s "$file")
            optimized_size=$(stat -c %s "$output")
            reduction=$(( (original_size - optimized_size) * 100 / original_size ))

            echo -e "''${BLUE}''${BOLD}Original size''${YELLOW}:''${RESET} $(numfmt --to=iec-i --suffix=B "$original_size")"
            echo -e "''${BLUE}''${BOLD}Optimized size''${YELLOW}:''${RESET} $(numfmt --to=iec-i --suffix=B "$optimized_size")"
            echo -e "''${BLUE}''${BOLD}Reduction''${YELLOW}:''${RESET} $reduction%"
          fi

          if $replace_original; then
            mv -f "$output" "$file"
          fi
        else
          rm -f "$output"
          echo -e "''${BOLD}''${RED}Error''${RED}:''${RESET} Optimization failed for ''${BOLD}$file''${RESET}."
        fi

        if $verbose; then
          echo -e "-------------------"
        fi
      done
    '';
}
