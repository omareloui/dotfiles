{
  writeShellApplication,
  libcanberra-gtk3,
  grimblast,
}:
writeShellApplication {
  name = "screenshot";
  runtimeInputs = [grimblast libcanberra-gtk3];
  text =
    /*
    bash
    */
    ''
      ${import ../utils/ansi.nix}

      version=2.0.0

      LONGOPTS=help,no-copy,sleep:,quite,preview
      OPTIONS=h,C,s:,q,p

      PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
      eval set -- "$PARSED"

      copy=1
      sleep=0
      quite=0
      preview=0

      while true; do
        case "$1" in
          -h | --help)
            echo -e ""
            echo -e "  ''${BOLD}Usage:''${END_BOLD}    ''${B_MAGENTA}$(basename "$0") ''${YELLOW}[''${B_RED}options''${DARK_GRAY}...''${YELLOW}]''${B_RED} ''${YELLOW}<''${GREEN}action''${YELLOW}>''${RESET}"
            echo -e "  ''${BOLD}Version:''${RESET}  ''${YELLOW}$version''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Description:''${RESET}"
            echo -e ""
            echo -e "    ''${B_GRAY}Take a screenshot.''${RESET}"
            echo -e ""
            echo -e "  ''${BOLD}Args:''${RESET}"
            echo -e ""
            echo -e "    ''${BOLD}''${GREEN}action''${WHITE} ''${YELLOW}{''${BLUE}full''${YELLOW}|''${BLUE}area''${YELLOW}|''${BLUE}window''${YELLOW}}''${RESET}"
            echo -e "      ''${BLUE}full''${RESET}      ''${B_RED}-''${RESET} Take a screenshot of the full screen."
            echo -e "      ''${BLUE}area''${RESET}      ''${B_RED}-''${RESET} Take a screenshot of an area you select."
            echo -e "      ''${BLUE}window''${RESET}    ''${B_RED}-''${RESET} Take a screenshot of a window."
            echo -e ""
            echo -e "  ''${BOLD}Options:''${RESET}"
            echo -e ""
            echo -e "    ''${BLUE}-h''${RESET}, ''${BLUE}--help''${RESET}        ''${B_RED}-''${RESET} Show this help."
            echo -e "    ''${BLUE}-C''${RESET}, ''${BLUE}--no-copy''${RESET}     ''${B_RED}-''${RESET} Don't copy the screenshot to clipboard."
            echo -e "    ''${BLUE}-s''${RESET}, ''${BLUE}--sleep ''${YELLOW}<''${MAGENTA}int''${YELLOW}>''${RESET} ''${B_RED}-''${RESET} Milliseconds to sleep before taking the screenshot for ''${BLUE}full''${RESET} or ''${BLUE}window''${RESET} actions."
            echo -e "    ''${BLUE}-q''${RESET}, ''${BLUE}--quite''${RESET}       ''${B_RED}-''${RESET} Don't notify countdown."
            echo -e "    ''${BLUE}-p''${RESET}, ''${BLUE}--preview''${RESET}     ''${B_RED}-''${RESET} preview the screenshot after it's taken."
            echo -e ""
            echo -e "  ''${BOLD}Examples:''${RESET}"
            echo -e ""
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} area"
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} -C window"
            echo -e "    ''${RED}\$''${RESET} ''${B_MAGENTA}$(basename "$0")''${RESET} -qs 3 full"
            echo -e ""
            exit 0
            ;;
          -C | --no-copy)
            copy=0
            shift
            ;;
          -q | --quite)
            quite=1
            shift
            ;;
          -p | --preview)
            preview=1
            shift
            ;;
          -s | --sleep)
            sleep="$2"
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

      NOTIFICATION_ID=6699
      time=$(date +%Y-%m-%d-%I-%M-%S)
      dir="''${PICS_DIR:-''${MYHOME:-$HOME/myhome}/pictures}/screenshots"
      filename="screenshot_''${time}.png"

      # notification_icon="$HOME/.local/share/icons/camera-shutter.png"
      # notification_icon2="$HOME/.local/share/icons/stopwatch.png"

      # if [[ ! -f $notification_icon ]]; then
      # 	source_file="$DOTFILES/assets/icons/camera-shutter.png"
      # 	if [[ ! -f "$source_file" ]]; then
      # 		echo -e "''${YELLOW_BG}''${BOLD}''${BLACK}Warning''${RESET} can't find the notification icon."
      # 	fi
      # 	cp "$source_file" "$notification_icon"
      # fi

      # if [[ ! -f $notification_icon2 ]]; then
      # 	source_file="$DOTFILES/assets/icons/stopwatch.png"
      # 	if [[ ! -f "$source_file" ]]; then
      # 		echo -e "''${YELLOW_BG}''${BOLD}''${BLACK}Warning''${RESET} can't find the counter icon."
      # 	fi
      # 	cp "$source_file" "$notification_icon2"
      # fi

      [[ ! -d $dir ]] && mkdir -p "$dir"

      function play_sound_effect() {
        canberra-gtk-play -i camera-shutter
      }

      function preview() {
      	if ((preview == 1)); then
      		xdg-open "$dir/$filename"
      	fi
      }

      function notify() {
        play_sound_effect

      	if [[ -e "$dir/$filename" ]]; then
      		message="Created $filename."
      		actions=""
      		((copy == 1)) && message+="<br>And copied to clipboard."
      		((preview == 0)) && actions+="preview,Preview"
      		ACTION="$(dunstify "Screenshot" "$message" -u low -i "$dir/$filename" -t 3000 -r "$NOTIFICATION_ID" --action="$actions")"
      		case "$ACTION" in
      		preview)
      			xdg-open "$dir/$filename"
      			;;
      		esac
      	fi
      }

      function shot_full() {
      	pushd "$dir" || exit 1
      	{
      		action=""
      		if ((copy == 1)); then
      			action+="copy"
      		fi
      		action+="save"

      		grimblast "$action" screen "$filename"
      	} && {
      		notify
      		preview
      	}
      	popd || exit 1
      }

      function shot_area() {
      	pushd "$dir" || exit 1

      	{
      		action=""
      		if ((copy == 1)); then
      			action+="copy"
      		fi
      		action+="save"

      		grimblast "$action" area "$filename"
      	} && {
      		notify
      		preview
      	}

      	popd || exit 1
      }

      function shot_window() {
      	pushd "$dir" || exit 1

      	{
      		action=""
      		if ((copy == 1)); then
      			action+="copy"
      		fi
      		action+="save"

      		grimblast "$action" area "$filename"
      	} && {
      		notify
      	}

      	popd || exit 1
      }

      countdown() {
      	if (($1 > 0)); then
      		for sec in $(seq "$1" -1 1); do
      			if ((quite == 0)); then
      				# dunstify -t 1000 -r "$NOTIFICATION_ID" -i "$notification_icon2" "Taking shot in : $sec"
      				dunstify -t 1000 -r "$NOTIFICATION_ID" "Taking shot in : $sec"
      			fi
      			sleep 1
      		done
      	fi
      }

      case $1 in
      full)
      	countdown "$sleep"
      	shot_full
      	;;
      window)
      	countdown "$sleep"
      	shot_window
      	;;
      area)
      	shot_area
      	;;
      *)
      	echo -e "''${RED_BG}''${BOLD}''${BLACK}Error''${RESET} invalid action."
      	echo -e "Run ''${YELLOW}\"''${B_MAGENTA}''${BOLD}$(basename "$0") --help''${RESET}''${YELLOW}\"''${RESET} for more information."
      	exit 1
      	;;
      esac
    '';
}
