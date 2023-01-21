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

cs("#!", t "#!/usr/bin/env bash", "auto")

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

------------------------------- End Refactoring -------------------------------

return snippets, autosnippets
