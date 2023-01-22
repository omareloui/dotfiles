#!/usr/bin/env bash

. "$(dirname "$0")/../utils.sh"

function check_package_installed {
	dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -c "ok installed"
}

function update_packages {
	manager="apt"
	(($(check_package_installed nala) == 1)) && manager="nala"
	sudo $manager update && sudo $manager upgrade -y
}

function install_package {
	read -r -a pkg_name <<<"$1"
	should_update=$2
	has_nala=$(check_package_installed nala)

	manager="apt"

	((has_nala == 1)) && manager="nala"

	[[ -z $should_update ]] && should_update=0

	if ((should_update == 1)); then
		update_packages
	fi

	sudo "$manager" install -y "${pkg_name[@]}"
}

function add_ppa {
	ppa=$1
	sudo add-apt-repository -y "$ppa"
}

function add_ppa_and_install {
	ppa=$1
	_pkg_name=$2
	sudo add-apt-repository -y "$ppa"
	install_package "$_pkg_name" 1
}

function git_clone {
	link=$1
	branch_name=$2
	dest=$3

	[[ -z $branch_name ]] && branch_name="main"
	if [[ -z $dest ]]; then
		git clone "$link" --depth 1 --branch "$branch_name" --single-branch
	else
		git clone "$link" \
			--depth 1 \
			--branch "$branch_name" \
			--single-branch \
			"$dest"
	fi
}

function install_with_pnpm {
	read -r -a pkg_name <<<"$1"
	has_node=$(check_package_installed nodejs)

	((has_node == 0)) && {
		echo -e "${RED}You have to have node installed to install commitizen${RESET}"
		exit 1
	}

	has_pnpm="$(which pnpm 2>/dev/null | grep -c "pnpm")"

	if ((has_pnpm == 1)); then
		pnpm -g add "${pkg_name[@]}"
	fi

	has_npm="$(which npm 2>/dev/null | grep -c "npm")"
	if ((has_npm == 0)); then
		echo -e "${RED}You have to have at npm to run install ${pkg_name[*]}.${RESET}"
		exit 1
	fi
	npm i -g "${pkg_name[@]}"
}
