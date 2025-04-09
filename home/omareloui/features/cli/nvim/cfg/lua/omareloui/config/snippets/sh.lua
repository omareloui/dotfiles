local ls = require "luasnip" --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep --}}}

local snippets_config_factory = require "omareloui.config.snippets.utils"
local cs, snippets, autosnippets = snippets_config_factory("*.sh", "ShellSnippets")

------------------------------ Start Refactoring ------------------------------

local ansi = [[
BOLD="\e[1m"         END_BOLD="\e[22m"
UNDERLINE="\e[4m"    END_UNDERLINE="\e[24m"
REVERSE_TEXT="\e[7m" END_REVERSE="\e[27m"

BLACK="\e[30m"   BLACK_BG="\e[40m"
WHITE="\e[97m"   WHITE_BG="\e[107m"

RED="\e[31m"     RED_BG="\e[41m"
GREEN="\e[32m"   GREEN_BG="\e[42m"
YELLOW="\e[33m"  YELLOW_BG="\e[43m"
BLUE="\e[34m"    BLUE_BG="\e[44m"
MAGENTA="\e[35m" MAGENTA_BG="\e[45m"
CYAN="\e[36m"    CYAN_BG="\e[46m"

B_GRAY="\e[37m" B_GRAY_BG="\e[47m"
DARK_GRAY="\e[90m"   DARK_GRAY_BG="\e[100m"

B_RED="\e[91m"     B_RED_BG="\e[101m"
B_GREEN="\e[92m"   B_GREEN_BG="\e[102m"
B_YELLOW="\e[93m"  B_YELLOW_BG="\e[103m"
B_BLUE="\e[94m"    B_BLUE_BG="\e[104m"
B_MAGENTA="\e[95m" B_MAGENTA_BG="\e[105m"
B_CYAN="\e[96m"    B_CYAN_BG="\e[106m"

RESET="\e[0m"]]

cs("#!", t "#!/usr/bin/env bash", "auto")

cs(
  "parseargs",
  fmt(
    [[version=1.0.0

verbose=0

LONGOPTS=verbose,help
OPTIONS=vh

PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
eval set -- "$PARSED"

while true; do
  case "$1" in
    -v | --verbose)
      verbose=1
      shift
      ;;
    -h | --help)
      echo -e ""
      echo -e "  ${{BOLD}}Usage:${{END_BOLD}}    $(basename "$0") ${{YELLOW}}[${{B_RED}}options${{DARK_GRAY}}...${{YELLOW}}]${{RESET}}" # ${{YELLOW}}<${{GREEN}}action${{YELLOW}}>${{RESET}}"
      echo -e "  ${{BOLD}}Version:${{RESET}}  ${{YELLOW}}$version${{RESET}}"
      echo -e ""
      echo -e "  ${{BOLD}}Description:${{RESET}}"
      echo -e ""
      echo -e "    ${{B_GRAY}}{}${{RESET}}"
      # echo -e ""
      # echo -e "  ${{BOLD}}Args:${{RESET}}"
      # echo -e ""
      # echo -e "    ${{BOLD}}${{GREEN}}action${{WHITE}} ${{YELLOW}}{{${{BLUE}}full${{YELLOW}}|${{BLUE}}area${{YELLOW}}|${{BLUE}}window${{YELLOW}}}}${{RESET}}"
      # echo -e "      ${{BLUE}}full${{RESET}}      ${{B_RED}}-${{RESET}} Take a screenshot of the full screen."
      # echo -e "      ${{BLUE}}area${{RESET}}      ${{B_RED}}-${{RESET}} Take a screenshot of an area you select."
      # echo -e "      ${{BLUE}}window${{RESET}}    ${{B_RED}}-${{RESET}} Take a screenshot of a window."
      echo -e ""
      echo -e "  ${{BOLD}}Options:${{RESET}}"
      echo -e ""
      echo -e "    ${{BLUE}}-h${{RESET}}, ${{BLUE}}--help${{RESET}}       ${{B_RED}}-${{RESET}} Show this help and exit."
      echo -e "    ${{BLUE}}-v${{RESET}}, ${{BLUE}}--verbose${{RESET}}    ${{B_RED}}-${{RESET}} Explain what is being done."
      echo -e ""
      # echo -e "  ${{BOLD}}Examples:${{RESET}}"
      # echo -e ""
      # echo -e "    ${{RED}}\$${{RESET}} ${{B_MAGENTA}}$(basename "$0")${{RESET}} area"
      # echo -e "    ${{RED}}\$${{RESET}} ${{B_MAGENTA}}$(basename "$0")${{RESET}} -C window"
      # echo -e "    ${{RED}}\$${{RESET}} ${{B_MAGENTA}}$(basename "$0")${{RESET}} -qs 3 full"
      # echo -e ""
      exit 0
      ;;
    --)
      shift
      break
      ;;
    *)
      echo -e "${{RED}}Error:${{RESET}} Programming error"
      exit 3
      ;;
  esac
done

function print() {{
	declare _preset
	_text=$1

	if [ -n "$2" ]; then
		_text=$2
		_level=$1

		case "$_level" in
		info)
			_preset="${{CYAN}}Info${{YELLOW}}:${{RESET}} "
			;;
		success)
			_preset="${{GREEN}}Success${{YELLOW}}:${{RESET}} "
			;;
		warning)
			_preset="${{YELLOW}}Warning${{B_RED}}:${{RESET}} "
			;;
		error)
			_preset="${{RED}}Error${{YELLOW}}:${{RESET}} "
			;;
		error_bg)
			_preset="${{B_RED_BG}}Error${{RESET}}${{YELLOW}}:${{RESET}} "
			;;
		*)
			print error "Invalid print option"
			exit 3
			;;
		esac
	fi

  echo -e "$_preset$_text"
}}

function p() {{
  if ((verbose == 1)); then
    print "$1" "$2"
  fi
}}

]],
    { i(1, "Script description") }
  )
)

cs("ansi", fmt(ansi, {}))

------------------------------- End Refactoring -------------------------------

return snippets, autosnippets
