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

BRIGHT_GRAY="\e[37m" BRIGHT_GRAY_BG="\e[47m"
DARK_GRAY="\e[90m"   DARK_GRAY_BG="\e[100m"

BRIGHT_RED="\e[91m"     BRIGHT_RED_BG="\e[101m"
BRIGHT_GREEN="\e[92m"   BRIGHT_GREEN_BG="\e[102m"
BRIGHT_YELLOW="\e[93m"  BRIGHT_YELLOW_BG="\e[103m"
BRIGHT_BLUE="\e[94m"    BRIGHT_BLUE_BG="\e[104m"
BRIGHT_MAGENTA="\e[95m" BRIGHT_MAGENTA_BG="\e[105m"
BRIGHT_CYAN="\e[96m"    BRIGHT_CYAN_BG="\e[106m"

RESET="\e[0m"]]

cs("#!", t "#!/usr/bin/env bash", "auto")

cs(
  "!#",
  fmt(
    string.format(
      [[#!/usr/bin/env bash

version=1.0.0

%8s



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
      echo -e "  ${{BOLD}}Usage:${{END_BOLD}}    $(basename "$0") ${{YELLOW}}[${{BRIGHT_RED}}OPTIONS${{DARK_GRAY}}...${{YELLOW}}]${{RESET}}" # ${{GREEN}}ARGUMENTS${{WHITE}}${{RESET}}"
      echo -e "  ${{BOLD}}Version:${{RESET}}  ${{YELLOW}}$version${{RESET}}"
      echo -e ""
      echo -e "  ${{BOLD}}Description:${{RESET}}"
      echo -e ""
      echo -e "    ${{BRIGHT_GRAY}}{}${{RESET}}"
      # echo -e ""
      # echo -e "  ${{BOLD}}Args:${{RESET}}"
      # echo -e ""
      # echo -e "    ${{BOLD}}${{GREEN}}ACTION${{WHITE}} ${{YELLOW}}{{${{BLUE}}full${{YELLOW}}|${{BLUE}}area${{YELLOW}}|${{BLUE}}window${{YELLOW}}}}${{RESET}}"
      # echo -e "      ${{BLUE}}full${{RESET}}      ${{BRIGHT_RED}}-${{RESET}} Take a screenshot of the full screen."
      # echo -e "      ${{BLUE}}area${{RESET}}      ${{BRIGHT_RED}}-${{RESET}} Take a screenshot of an area you select."
      # echo -e "      ${{BLUE}}window${{RESET}}    ${{BRIGHT_RED}}-${{RESET}} Take a screenshot of a window."
      echo -e ""
      echo -e "  ${{BOLD}}Options:${{RESET}}"
      echo -e ""
      echo -e "    ${{BLUE}}-h${{RESET}}, ${{BLUE}}--help${{RESET}}       ${{BRIGHT_RED}}-${{RESET}} Show this help."
      echo -e "    ${{BLUE}}-v${{RESET}}, ${{BLUE}}--verbose${{RESET}}    ${{BRIGHT_RED}}-${{RESET}} Prints out the process state."
      echo -e ""
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

function p() {{
  if ((verbose == 1)); then
    echo -e "$1"
  fi
}}

]],
      ansi
    ),
    { i(1, "Script description") }
  ),
  "auto"
)

cs(
  "parseargs",
  fmt(
    [[
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
		echo "Usage: $(basename "$0") [OPTION]..."
		echo "{}"
		echo ""
		echo "-v, --verbose     prints out the process state"
		echo "-h, --help        show this help prompt"
		echo ""
		exit 0
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

function p() {{
	if ((verbose == 1)); then
		echo -e "$1"
	fi
}}

]],
    {
      i(1, "What the script do"),
    }
  )
)

cs("ansi", fmt(ansi, {}))

------------------------------- End Refactoring -------------------------------

return snippets, autosnippets
