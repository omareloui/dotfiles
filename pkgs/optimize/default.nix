{
  writeShellApplication,
  ffmpeg,
  ghostscript,
  imagemagick,
  oxipng,
  pngquant,
  gifsicle,
  ...
}:
writeShellApplication {
  name = "optimize";
  runtimeInputs = [ffmpeg ghostscript imagemagick oxipng pngquant gifsicle];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      version=2.0.0

      custom_output=""
      resize=false
      max_width=1920
      max_height=1080
      level=balanced
      image_quality=""
      verbose=true
      override_original=false
      remove_original=false
      force_smaller=false

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
        echo -e "  ''${YELLOW}<''${GREEN}media_file''${DARK_GRAY}...''${YELLOW}>''${RESET}    ''${B_RED}-''${RESET} One or more image, video or pdf files to optimize."
        echo -e ""
        echo -e "''${BOLD}Options:''${RESET}"
        echo -e ""
        echo -e "  ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}                ''${B_RED}-''${RESET} Show this help message."
        echo -e "  ''${BLUE}-l''${RESET}, ''${BLUE}--level ''${YELLOW}<''${MAGENTA}level''${YELLOW}>''${RESET}       ''${B_RED}-''${RESET} ''${GREEN}light''${RESET} (near-lossless), ''${GREEN}balanced''${RESET} or ''${GREEN}max''${RESET} (smallest) ''${DARK_GRAY}(default: $level)''${RESET}."
        echo -e "  ''${BLUE}-R''${RESET}, ''${BLUE}--resize''${RESET}              ''${B_RED}-''${RESET} Resize the image or video."
        echo -e "  ''${BLUE}-W''${RESET}, ''${BLUE}--max-width ''${YELLOW}<''${MAGENTA}int''${YELLOW}>''${RESET}     ''${B_RED}-''${RESET} When \`--resize\` is provided, set maximum width ''${DARK_GRAY}(default: $max_width)''${RESET}."
        echo -e "  ''${BLUE}-H''${RESET}, ''${BLUE}--max-height ''${YELLOW}<''${MAGENTA}int''${YELLOW}>''${RESET}    ''${B_RED}-''${RESET} When \`--resize\` is provided, set maximum height ''${DARK_GRAY}(default: $max_height)''${RESET}."
        echo -e "  ''${BLUE}-Q''${RESET}, ''${BLUE}--image-quality ''${YELLOW}<''${MAGENTA}int''${YELLOW}>''${RESET} ''${B_RED}-''${RESET} Override the jpeg/webp quality ''${DARK_GRAY}(1-100, higher is better; default: from the level)''${RESET}."
        echo -e "  ''${BLUE}-O''${RESET}, ''${BLUE}--override-original''${RESET}   ''${B_RED}-''${RESET} Override original file with optimized ones."
        echo -e "  ''${BLUE}-r''${RESET}, ''${BLUE}--remove-original''${RESET}     ''${B_RED}-''${RESET} Remove the original file."
        echo -e "  ''${BLUE}-o''${RESET}, ''${BLUE}--output''${RESET}              ''${B_RED}-''${RESET} Specify the output file."
        echo -e "  ''${BLUE}-f''${RESET}, ''${BLUE}--force-smaller''${RESET}       ''${B_RED}-''${RESET} Discard the result when it isn't smaller than the original."
        echo -e "  ''${BLUE}-q''${RESET}, ''${BLUE}--quite''${RESET}               ''${B_RED}-''${RESET} Make the command quiter."
        echo -e ""
        echo -e "''${BOLD}Levels:''${RESET}"
        echo -e ""
        echo -e "  ''${GREEN}light''${RESET}     jpeg/webp q92, png+gif lossless, pdf 300dpi, video crf 22 (x265)"
        echo -e "  ''${GREEN}balanced''${RESET}  jpeg/webp q85, png+gif lossless, pdf 200dpi, video crf 24 (x265)"
        echo -e "  ''${GREEN}max''${RESET}       jpeg/webp q75, png+gif lossy,    pdf 150dpi, video crf 28 (x265)"
        echo -e ""
        echo -e "''${BOLD}Examples:''${RESET}"
        echo -e ""
        echo -e "  ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} video1.mp4 img1.png"
        echo -e "  ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} -l max -Of img1.jpg"
        echo -e "  ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} -r -RH 720 video1.mp4"
        echo -e ""
      }

      LONGOPTS=help,level:,max-width:,max-height:,remove-original,override-original,resize,image-quality:,output:,force-smaller,quite
      OPTIONS=hl:W:H:rORQ:o:fq

      PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
      eval set -- "$PARSED"

      while true; do
        case "$1" in
        -h | --help)
          show_help
          exit 0
          ;;
        -l | --level)
          level="$2"
          shift 2
          ;;
        -R | --resize)
          resize=true
          shift
          ;;
        -Q | --image-quality)
          image_quality="$2"
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
        -O | --override-original)
          override_original=true
          shift
          ;;
        -r | --remove-original)
          remove_original=true
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
        -f | --force-smaller)
          force_smaller=true
          shift
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

      case "$level" in
      light)
        jpeg_quality=92
        png_lossy=false
        gif_lossy=0
        pdf_preset=/printer
        pdf_dpi=300
        x265_crf=22
        x264_crf=20
        vp9_crf=30
        audio_bitrate=192k
        ;;
      balanced)
        jpeg_quality=85
        png_lossy=false
        gif_lossy=0
        pdf_preset=/ebook
        pdf_dpi=200
        x265_crf=24
        x264_crf=22
        vp9_crf=33
        audio_bitrate=160k
        ;;
      max)
        jpeg_quality=75
        png_lossy=true
        gif_lossy=40
        pdf_preset=/ebook
        pdf_dpi=150
        x265_crf=28
        x264_crf=26
        vp9_crf=38
        audio_bitrate=128k
        ;;
      *)
        echo -e "''${BOLD}''${RED}Error''${YELLOW}:''${RESET} Unknown level: ''${BOLD}$level''${RESET} (light, balanced or max)." >&2
        exit 3
        ;;
      esac

      if [[ -n $image_quality ]]; then
        jpeg_quality="$image_quality"
      fi

      if [[ $# -eq 0 ]]; then
        echo "''${BOLD}''${RED}Error''${YELLOW}:''${RESET} No media files provided."
        show_help
        exit 1
      fi

      # `magick` geometry: only shrink, keep the aspect ratio.
      function resize_args {
        if $resize; then
          echo "-resize"
          echo "''${max_width}x''${max_height}>"
        fi
      }

      function optimize_jpeg {
        local args
        mapfile -t args < <(resize_args)
        # -auto-orient bakes the EXIF rotation in, so stripping metadata can't
        # leave photos sideways.
        magick "$1" -auto-orient "''${args[@]}" -strip \
          -quality "$jpeg_quality" -sampling-factor 4:2:0 -interlace JPEG \
          "$2"
      }

      function optimize_webp {
        local args
        mapfile -t args < <(resize_args)
        # Lossless webps (VP8L chunk) stay lossless.
        if [[ "$(head -c 16 "$1" | tail -c 4)" == "VP8L" ]]; then
          magick "$1" -auto-orient "''${args[@]}" -strip \
            -define webp:lossless=true -define webp:method=6 "$2"
        else
          magick "$1" -auto-orient "''${args[@]}" -strip \
            -quality "$jpeg_quality" -define webp:method=6 "$2"
        fi
      }

      function optimize_png {
        local input="$1"
        if $resize; then
          local args
          mapfile -t args < <(resize_args)
          magick "$1" "''${args[@]}" "$2"
          input="$2"
        fi
        if $png_lossy; then
          pngquant --force --skip-if-larger --quality 65-90 --speed 1 --output "$2" -- "$input" || cp -f "$input" "$2"
          input="$2"
        fi
        oxipng --quiet --opt 4 --strip safe --out "$2" -- "$input"
      }

      function optimize_gif {
        local args=(-O3)
        if ((gif_lossy > 0)); then
          args+=("--lossy=$gif_lossy")
        fi
        if $resize; then
          args+=(--resize-fit "''${max_width}x''${max_height}")
        fi
        gifsicle "''${args[@]}" "$1" -o "$2"
      }

      function audio_codec {
        ffprobe -v error -select_streams a:0 -show_entries stream=codec_name \
          -of default=noprint_wrappers=1:nokey=1 "$1" 2>/dev/null || true
      }

      function optimize_videos {
        local scale_width=-2
        local scale_height=-2
        if $resize; then
          scale_width="$max_width"
          scale_height="$max_height"
        fi
        local scale="scale='min($scale_width,iw)':'min($scale_height,ih)':force_original_aspect_ratio=decrease:force_divisible_by=2"
        if ! $resize; then
          scale="scale=trunc(iw/2)*2:trunc(ih/2)*2"
        fi

        # Keep the audio as is when it's already a good codec for the container.
        local acodec
        acodec="$(audio_codec "$1")"

        local video_args audio_args
        case "$3" in
        "webm")
          video_args=(-c:v libvpx-vp9 -crf "$vp9_crf" -b:v 0 -row-mt 1)
          case "$acodec" in
          opus | vorbis) audio_args=(-c:a copy) ;;
          *) audio_args=(-c:a libopus -b:a 128k) ;;
          esac
          ;;
        "avi")
          video_args=(-c:v libx264 -crf "$x264_crf" -preset slow)
          case "$acodec" in
          mp3) audio_args=(-c:a copy) ;;
          *) audio_args=(-c:a libmp3lame -b:a "$audio_bitrate") ;;
          esac
          ;;
        *)
          video_args=(-c:v libx265 -crf "$x265_crf" -preset slow -x265-params log-level=error)
          case "$acodec" in
          aac | opus) audio_args=(-c:a copy) ;;
          *) audio_args=(-c:a aac -b:a "$audio_bitrate") ;;
          esac
          if [[ "$3" != "mkv" ]]; then
            # hvc1 tag so Apple players accept the HEVC stream.
            video_args+=(-tag:v hvc1 -movflags +faststart)
          fi
          ;;
        esac

        ffmpeg -y -loglevel error -i "$1" \
          -map 0:v:0 -map "0:a?" \
          -vf "$scale" \
          "''${video_args[@]}" "''${audio_args[@]}" \
          -map_metadata 0 \
          "$2"
      }

      function optimize_pdf {
        gs \
          -q \
          -dNOPAUSE \
          -dBATCH \
          -dSAFER \
          -sDEVICE=pdfwrite \
          -dCompatibilityLevel=1.7 \
          -dPDFSETTINGS="$pdf_preset" \
          -dEmbedAllFonts=true \
          -dSubsetFonts=true \
          -dDetectDuplicateImages=true \
          -dDownsampleColorImages=true \
          -dColorImageDownsampleType=/Bicubic \
          -dColorImageResolution="$pdf_dpi" \
          -dDownsampleGrayImages=true \
          -dGrayImageDownsampleType=/Bicubic \
          -dGrayImageResolution="$pdf_dpi" \
          -dDownsampleMonoImages=true \
          -dMonoImageDownsampleType=/Subsample \
          -dMonoImageResolution=$((pdf_dpi * 2)) \
          -sOutputFile="$2" \
          "$1"
      }

      function optimize_one {
        case "$3" in
        "pdf") optimize_pdf "$1" "$2" ;;
        "jpg" | "jpeg") optimize_jpeg "$1" "$2" ;;
        "webp") optimize_webp "$1" "$2" ;;
        "png") optimize_png "$1" "$2" ;;
        "gif") optimize_gif "$1" "$2" ;;
        "mp4" | "m4v" | "avi" | "mov" | "mkv" | "webm") optimize_videos "$1" "$2" "$3" ;;
        esac
      }

      failed=0

      for file in "$@"; do
        if [[ ! -f "$file" ]]; then
          echo -e "''${BOLD}''${RED}Error''${YELLOW}:''${RESET} File not found: ''${BOLD}''${DARK_GRAY}$file''${RESET}." >&2
          failed=1
          continue
        fi

        ext="''${file##*.}"
        ext="''${ext,,}" # Convert to lowercase

        case "$ext" in
        "pdf" | "jpg" | "jpeg" | "png" | "webp" | "gif" | "mp4" | "m4v" | "avi" | "mov" | "mkv" | "webm") ;;
        *)
          echo -e "''${BOLD}''${YELLOW}Warning''${RED}:''${RESET} Unsupported file type: ''${BOLD}$file''${RESET}." >&2
          continue
          ;;
        esac

        output="$custom_output"
        if [[ -z $custom_output ]]; then
          output="''${file%.*}.optimized.$ext"
        fi

        if $verbose; then
          echo -e "''${BLUE}''${BOLD}Processing''${YELLOW}:''${RESET} $file ''${DARK_GRAY}($level)''${RESET}"
        fi

        # Called in a condition so a failure doesn't stop the batch (errexit).
        if ! optimize_one "$file" "$output" "$ext" || [[ ! -s "$output" ]]; then
          rm -f "$output"
          echo -e "''${BOLD}''${RED}Error''${YELLOW}:''${RESET} Optimization failed for ''${BOLD}$file''${RESET}." >&2
          failed=1
          continue
        fi

        original_size=$(stat -c %s "$file")
        optimized_size=$(stat -c %s "$output")

        if $verbose; then
          reduction=$(((original_size - optimized_size) * 100 / original_size))

          echo -e "''${BLUE}''${BOLD}Original size''${YELLOW}:''${RESET} $(numfmt --to=iec-i --suffix=B "$original_size")"
          echo -e "''${BLUE}''${BOLD}Optimized size''${YELLOW}:''${RESET} $(numfmt --to=iec-i --suffix=B "$optimized_size")"
          echo -e "''${BLUE}''${BOLD}Reduction''${YELLOW}:''${RESET} $reduction%"
        fi

        if $force_smaller && ((optimized_size >= original_size)); then
          rm -f "$output"
          if $verbose; then
            echo -e "''${BOLD}''${YELLOW}Warning''${RED}:''${RESET} Optimized file isn't smaller, keeping the original ''${BOLD}$file''${RESET}."
          fi
        elif $override_original; then
          mv -f "$output" "$file"
        elif $remove_original; then
          rm -f "$file"
        fi

        if $verbose; then
          echo -e "-------------------"
        fi
      done

      exit "$failed"
    '';
}
