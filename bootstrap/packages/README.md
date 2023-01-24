# Packages and Applications

Scripts to install packages and applications I use.

> **WARNING:** not all of the scripts were tested, yet.

## Available scripts

- `index.sh`: to run all packages bootstrap scripts.

- `packages.sh`: to install the common package I might need.

  - Packages dependencies
    - `build-essential`: package that is required by other packages.
    - `libfuse2`: can't remember what this for. But I'm leaving it anyway.

  - Scripts dependencies
    - `maim`: the screenshot script is basically a wrapper for maim.
    - `xdotool` required for the screenshot script.
    - `viewnior` required for the screenshot script to preview the image after
      it's taken.
    - `bmon` used by rofi to preview internet bandwidth.

  - Terminal utilities
    - `bat`: a better `cat` replacment.
    - `bpytop`: resource monitoring utility.
    - `cmus`: music player.
    - `curl`: transferring data utility.
    - `entr`: no idea what was that for or what it does.
    - `exa`: better `ls`.
    - `fd-find`: better `find`.
    - `ffmpeg`: I can't live without it.
    - `fzf`: fuzzy finder.
    - `ripgrep`: better `grep`.
    - `tree`: file structure previewer.
    - `wmctrl`: don't know what is it for either.
    - `xclip`: to send test to clipboard.
    - `zoxide`: better `cd`.

  - Applications
    - `keepassxc`: password manager.
    - `neovim`: better `vim`.
    - `telegram-desktop`: messenger.
    - `tmux`: a terminal multiplexer.
    - `vlc`: doesn't need description.
    - `rofi` a window switcher.

  - Package managers
    - `nala`: better `apt`.
    - `pip`: package manager for `python`.

- `betterlockscreen.sh`: to lock screen.

  - Requires
    - `imagemagick.sh`: to manipulate images.
    - `i3lock-color.sh`: the base for `betterlockscreen`.

- `fish.sh`: installs the `fish` shell and sets it as the default shell.
- `starship.sh`: install the `starship` prompt.

- `awesomewm`: Awesome Window Manager.
- `picom`: a compositor.

- `lf`: a file browser.

- `node.sh`: installs `node`, `nvm`, and `pnpm`.
- `deno.sh`: installs `deno`.
- `golang.sh`: installs `golang`.

- `commitizen`: to make sure my git messages follow the `JIRA` commit messages
  style.

- `gnome.sh`: installs `gnome-shell-extensions` and `gnome-tweaks`
- `ulauncher.sh`: installs `ulauncher` and it's extenstions dependencies.

- `inkscape.sh`: for victor editing.

- `tpm.sh`: a package manager for `tmux`.

- `zk.sh`: zettelkasten notes manager.
