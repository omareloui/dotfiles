{
  writeShellApplication,
  ffmpeg,
  ghostscript,
  imagemagick,
  oxipng,
  pngquant,
  gifsicle,
  findutils,
  coreutils,
  ...
}:
writeShellApplication {
  name = "optimize";
  runtimeInputs = [ffmpeg ghostscript imagemagick oxipng pngquant gifsicle findutils coreutils];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      version=2.1.0

      # No colors when not writing to a terminal (e.g. yazi's task log).
      if [[ -n "''${NO_COLOR:-}" || ! -t 1 ]]; then
        while read -r _ var; do
          [[ -n "$var" ]] && declare "''${var%%=*}="
        done <<'ANSI'
      ${import ../utils/ansi.nix}
      ANSI
      fi

      summary_file=""
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
        echo -e "  ''${YELLOW}<''${GREEN}media_file''${DARK_GRAY}...''${YELLOW}>''${RESET}    ''${B_RED}-''${RESET} One or more image, video or pdf files, or directories (walked recursively), to optimize."
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
        echo -e "  ''${BLUE}-s''${RESET}, ''${BLUE}--summary-file ''${YELLOW}<''${MAGENTA}path''${YELLOW}>''${RESET} ''${B_RED}-''${RESET} Write the level (info/warn) and a one-line summary to this file."
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

      LONGOPTS=help,level:,max-width:,max-height:,remove-original,override-original,resize,image-quality:,output:,force-smaller,quite,summary-file:
      OPTIONS=hl:W:H:rORQ:o:fqs:

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
        -s | --summary-file)
          summary_file="$2"
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

      supported_exts=(pdf jpg jpeg png webp gif mp4 m4v avi mov mkv webm)
      find_names=()
      for e in "''${supported_exts[@]}"; do
        find_names+=(-o -iname "*.$e")
      done

      # Expand directories (recursively) into the supported files inside them.
      # Each file is optimized next to itself, so the tree layout is kept.
      files=()
      for arg in "$@"; do
        if [[ -d "$arg" ]]; then
          while IFS= read -r -d "" found; do
            files+=("$found")
          done < <(find "$arg" -type f \( "''${find_names[@]:1}" \) ! -name '*.optimized.*' -print0 | sort -z)
        else
          files+=("$arg")
        fi
      done
      set -- "''${files[@]}"

      function log {
        if $verbose; then
          echo -e "$@"
        fi
      }

      # A sub-step of the current file.
      function step {
        log "      ''${DARK_GRAY}->''${RESET} $*"
      }

      function human {
        numfmt --to=iec-i --suffix=B "$1"
      }

      # join <sep> <items...>
      function join {
        local sep=$1 out
        shift
        printf -v out "%s$sep" "$@"
        echo "''${out%"$sep"}"
      }

      function fmt_time {
        local s=$1
        if ((s >= 3600)); then
          printf "%d:%02d:%02d" $((s / 3600)) $((s % 3600 / 60)) $((s % 60))
        else
          printf "%02d:%02d" $((s / 60)) $((s % 60))
        fi
      }

      # `magick` geometry: only shrink, keep the aspect ratio.
      function resize_args {
        if $resize; then
          echo "-resize"
          echo "''${max_width}x''${max_height}>"
        fi
      }

      resize_note=""
      if $resize; then
        resize_note=", fit in ''${max_width}x''${max_height}"
      fi

      function optimize_jpeg {
        local args
        mapfile -t args < <(resize_args)
        step "imagemagick: quality $jpeg_quality, auto-orient, strip metadata$resize_note"
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
          step "imagemagick: lossless webp, strip metadata$resize_note"
          magick "$1" -auto-orient "''${args[@]}" -strip \
            -define webp:lossless=true -define webp:method=6 "$2"
        else
          step "imagemagick: lossy webp quality $jpeg_quality, strip metadata$resize_note"
          magick "$1" -auto-orient "''${args[@]}" -strip \
            -quality "$jpeg_quality" -define webp:method=6 "$2"
        fi
      }

      function optimize_png {
        local input="$1"
        if $resize; then
          local args
          mapfile -t args < <(resize_args)
          step "imagemagick: resize$resize_note"
          magick "$1" "''${args[@]}" "$2"
          input="$2"
        fi
        if $png_lossy; then
          step "pngquant: lossy palette, quality 65-90"
          if ! pngquant --force --skip-if-larger --quality 65-90 --speed 1 --output "$2" -- "$input"; then
            step "pngquant: no gain, keeping full colors"
            cp -f "$input" "$2"
          fi
          input="$2"
        fi
        step "oxipng: lossless, level 4, strip safe metadata"
        oxipng --quiet --opt 4 --strip safe --out "$2" -- "$input"
      }

      function optimize_gif {
        local args=(-O3)
        local note="lossless -O3"
        if ((gif_lossy > 0)); then
          args+=("--lossy=$gif_lossy")
          note="-O3, lossy $gif_lossy"
        fi
        if $resize; then
          args+=(--resize-fit "''${max_width}x''${max_height}")
        fi
        step "gifsicle: $note$resize_note"
        gifsicle "''${args[@]}" "$1" -o "$2"
      }

      function audio_codec {
        ffprobe -v error -select_streams a:0 -show_entries stream=codec_name \
          -of default=noprint_wrappers=1:nokey=1 "$1" 2>/dev/null || true
      }

      function duration_us {
        ffprobe -v error -show_entries format=duration -of csv=p=0 "$1" 2>/dev/null |
          awk '/^[0-9.]+$/ { printf "%d", $1 * 1000000; found = 1 } END { if (!found) print 0 }'
      }

      # Run ffmpeg and log its progress every 5%.
      # $1: duration of the input in microseconds (0 if unknown), rest: ffmpeg args.
      function ffmpeg_progress {
        local total_us=$1
        shift
        local start=$SECONDS
        ffmpeg -nostats -progress pipe:1 "$@" | {
          local next=0 cur=0 speed="?" pct elapsed eta
          while IFS="=" read -r key value; do
            case "$key" in
            out_time_us)
              if [[ "$value" =~ ^[0-9]+$ ]]; then
                cur=$value
              fi
              ;;
            speed)
              speed="''${value// /}"
              ;;
            progress)
              elapsed=$((SECONDS - start))
              if ((total_us > 0)); then
                pct=$((cur * 100 / total_us))
                if ((pct > 100)); then
                  pct=100
                fi
                if ((pct >= next)) || [[ "$value" == "end" ]]; then
                  eta=""
                  if ((pct > 0 && pct < 100)); then
                    eta=", eta $(fmt_time $((elapsed * (100 - pct) / pct)))"
                  fi
                  step "$(printf "%3d%%" "$pct")  $(fmt_time $((cur / 1000000))) / $(fmt_time $((total_us / 1000000)))  speed $speed$eta"
                  next=$((pct - pct % 5 + 5))
                fi
              elif [[ "$value" == "end" ]] || ((elapsed >= next)); then
                step "$(fmt_time $((cur / 1000000))) encoded, speed $speed"
                next=$((elapsed + 10))
              fi
              ;;
            esac
          done
        }
      }

      function optimize_videos {
        local scale="scale=trunc(iw/2)*2:trunc(ih/2)*2"
        if $resize; then
          scale="scale='min($max_width,iw)':'min($max_height,ih)':force_original_aspect_ratio=decrease:force_divisible_by=2"
        fi

        # Keep the audio as is when it's already a good codec for the container.
        local acodec
        acodec="$(audio_codec "$1")"

        local video_args audio_args video_note audio_note
        case "$3" in
        "webm")
          video_args=(-c:v libvpx-vp9 -crf "$vp9_crf" -b:v 0 -row-mt 1)
          video_note="vp9 crf $vp9_crf"
          case "$acodec" in
          opus | vorbis) audio_args=(-c:a copy) audio_note="audio kept ($acodec)" ;;
          *) audio_args=(-c:a libopus -b:a 128k) audio_note="audio $acodec -> opus 128k" ;;
          esac
          ;;
        "avi")
          video_args=(-c:v libx264 -crf "$x264_crf" -preset slow)
          video_note="x264 crf $x264_crf, preset slow"
          case "$acodec" in
          mp3) audio_args=(-c:a copy) audio_note="audio kept ($acodec)" ;;
          *) audio_args=(-c:a libmp3lame -b:a "$audio_bitrate") audio_note="audio $acodec -> mp3lame $audio_bitrate" ;;
          esac
          ;;
        *)
          video_args=(-c:v libx265 -crf "$x265_crf" -preset slow -x265-params log-level=error)
          video_note="x265 crf $x265_crf, preset slow"
          case "$acodec" in
          aac | opus) audio_args=(-c:a copy) audio_note="audio kept ($acodec)" ;;
          *) audio_args=(-c:a aac -b:a "$audio_bitrate") audio_note="audio $acodec -> aac $audio_bitrate" ;;
          esac
          if [[ "$3" != "mkv" ]]; then
            # hvc1 tag so Apple players accept the HEVC stream.
            video_args+=(-tag:v hvc1 -movflags +faststart)
          fi
          ;;
        esac

        if [[ -z "$acodec" ]]; then
          audio_note="no audio"
        fi

        local total_us
        total_us="$(duration_us "$1")"
        local length="unknown length"
        if ((total_us > 0)); then
          length="$(fmt_time $((total_us / 1000000)))"
        fi
        local dims
        dims="$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$1" 2>/dev/null || true)"

        step "ffmpeg: ''${dims:-?} $length, $video_note, $audio_note$resize_note"
        ffmpeg_progress "$total_us" -y -loglevel error -i "$1" \
          -map 0:v:0 -map "0:a?" \
          -vf "$scale" \
          "''${video_args[@]}" "''${audio_args[@]}" \
          -map_metadata 0 \
          "$2"
      }

      function optimize_pdf {
        step "ghostscript: $pdf_preset, images down to ''${pdf_dpi}dpi"
        # Without -q gs prints "Processing pages 1 through N." and "Page n".
        gs \
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
          "$1" | {
          local pages="?" page every=1 next=0 start=$SECONDS
          while read -r line; do
            if [[ "$line" =~ ^Processing\ pages\ [0-9]+\ through\ ([0-9]+) ]]; then
              pages="''${BASH_REMATCH[1]}"
              every=$((pages / 10 > 10 ? 10 : (pages / 10 > 0 ? pages / 10 : 1)))
              step "$pages pages"
            elif [[ "$line" =~ ^Page\ ([0-9]+) ]]; then
              page="''${BASH_REMATCH[1]}"
              # Log every ~10% of the pages, at least every 10 pages.
              if [[ "$pages" == "?" ]] || ((page >= next || page == pages)); then
                step "page $page/$pages ($(fmt_time $((SECONDS - start))))"
                if [[ "$pages" != "?" ]]; then
                  next=$((page + every))
                fi
              fi
            fi
          done
        }
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

      optimized_count=0
      unchanged_count=0
      skipped_count=0
      failed_names=()
      total_before=0
      total_after=0
      batch_start=$SECONDS
      total=$#
      index=0

      log "''${BOLD}Optimizing $total file(s)''${RESET} ''${DARK_GRAY}(level: $level)''${RESET}"

      for file in "$@"; do
        index=$((index + 1))
        name="''${file##*/}"

        if [[ ! -f "$file" ]]; then
          log ""
          log "''${BOLD}[$index/$total]''${RESET} $name"
          echo -e "      ''${RED}x''${RESET} File not found: ''${DARK_GRAY}$file''${RESET}" >&2
          failed_names+=("$name")
          continue
        fi

        ext="''${file##*.}"
        ext="''${ext,,}" # Convert to lowercase

        original_size=$(stat -c %s "$file")
        original_h="$(human "$original_size")"
        log ""
        log "''${BOLD}[$index/$total]''${RESET} $name ''${DARK_GRAY}($ext, $original_h)''${RESET}"

        if [[ " ''${supported_exts[*]} " != *" $ext "* ]]; then
          echo -e "      ''${YELLOW}!''${RESET} Unsupported file type, skipped" >&2
          skipped_count=$((skipped_count + 1))
          continue
        fi

        output="$custom_output"
        if [[ -z $custom_output ]]; then
          output="''${file%.*}.optimized.$ext"
        fi

        file_start=$SECONDS

        # Called in a condition so a failure doesn't stop the batch (errexit).
        if ! optimize_one "$file" "$output" "$ext" || [[ ! -s "$output" ]]; then
          rm -f "$output"
          echo -e "      ''${RED}x''${RESET} Optimization failed for $file" >&2
          failed_names+=("$name")
          continue
        fi

        optimized_size=$(stat -c %s "$output")
        took="$(fmt_time $((SECONDS - file_start)))"

        if $force_smaller && ((optimized_size >= original_size)); then
          rm -f "$output"
          unchanged_count=$((unchanged_count + 1))
          log "      ''${YELLOW}=''${RESET} $(human "$optimized_size") isn't smaller than $original_h, kept the original ''${DARK_GRAY}($took)''${RESET}"
          continue
        fi

        optimized_count=$((optimized_count + 1))
        total_before=$((total_before + original_size))
        total_after=$((total_after + optimized_size))

        reduction=$(((original_size - optimized_size) * 100 / original_size))
        result="saved to ''${output##*/}"
        if $override_original; then
          mv -f "$output" "$file"
          result="replaced the original"
        elif $remove_original; then
          rm -f "$file"
          result+=", removed the original"
        fi

        log "      ''${GREEN}ok''${RESET} $original_h -> $(human "$optimized_size") (-$reduction%), $result ''${DARK_GRAY}($took)''${RESET}"
      done

      # One-line summary.
      parts=()
      if ((optimized_count > 0)); then
        saved=$((total_before - total_after))
        parts+=("$optimized_count optimized, saved $(human "$saved") ($((saved * 100 / total_before))%)")
      fi
      if ((unchanged_count > 0)); then
        parts+=("$unchanged_count already optimal")
      fi
      if ((skipped_count > 0)); then
        parts+=("$skipped_count unsupported")
      fi
      if ((''${#failed_names[@]} > 0)); then
        parts+=("''${#failed_names[@]} failed: $(join ", " "''${failed_names[@]}")")
      fi
      if ((''${#parts[@]} == 0)); then
        parts=("nothing to do")
      fi
      summary="$(join "; " "''${parts[@]}")"

      log ""
      log "''${BOLD}Done''${RESET} in $(fmt_time $((SECONDS - batch_start))): $summary"

      if [[ -n "$summary_file" ]]; then
        summary_level=info
        if ((''${#failed_names[@]} > 0)); then
          summary_level=warn
        fi
        printf "%s\n%s\n" "$summary_level" "$summary" >"$summary_file"
      fi

      exit $((''${#failed_names[@]} > 0))
    '';
}
