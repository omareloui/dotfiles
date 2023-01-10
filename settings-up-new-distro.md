# Setting Up a New Distro

## Applications and packages included in `scripts/install_packages.sh`

- bat
- bpytop
- build-essential
- deno
- entr
- exa
- fd-find
- ffmpeg
- fish
- fzf
- gnome-shell-extensions
- gnome-tweaks
- go
- incscape
- inkscape
- keepassxc
- keepassxc
- libfuse2
- neovim
- nodejs
- pnpm
- python3-pip
- ripgreb
- starship-prompt
- telegram-desktop
- telegram-desktop
- tmux
- tpm
- ulancher
- ulauncher
- vlc
- wmctrl
- xclip
- zk
- zoxide

## Applications and packages to download manually

- edge
- vscode
- zoom

---

## Fonts

Install [nerd fonts](https://www.nerdfonts.com/) for exa icons to work and for
VSCode font with ligatures.

- [3270 Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/3270.zip).
- [FiraCode](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip).

---

## Extensions

### ULauncher extensions

Needs to install `wmctrl` to focus on open.

- [Calculate Anything](https://github.com/tchar/ulauncher-albert-calculate-anything)

  Requires `pytz`.

- [Translate](https://github.com/manahter/ulauncher-translate)
- [Files Fuzzy Search](https://github.com/hillaryychan/ulauncher-fzf)

  Requires `fzf` and `fd-find`.

- [KeePassXC](https://github.com/pbkhrv/ulauncher-keepassxc)
- [Password Generator](https://github.com/rkarami/ulauncher-password-generator)
- [VSCode Recent](https://github.com/plibither8/ulauncher-vscode-recent)

  Requires `fuzzywuzzy`.

- [Notion Search](https://github.com/hakonmh/ulauncher-notion-search)

  Requires `tornado` and `thefuzz`.

- [Terminal Runner](https://ext.ulauncher.io/-/github-lighttigerxiv-ulauncher-terminal-runner-extension)

### Gnome extensions

- [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/)
- [Caffeine](https://extensions.gnome.org/extension/517/caffeine/)
- [GSConnect](https://extensions.gnome.org/extension/1319/gsconnect/)
- [Open Weather](https://extensions.gnome.org/extension/750/openweather/)
- [Auto Select Headset](https://extensions.gnome.org/extension/3928/auto-select-headset/)

---

## Setup checklist

- [ ] Setup Github
  - [ ] Create ssh key by running
        `ssh-keygen -t rsa -b 4096 -C "omareloui@hotmail.com"`.
  - [ ] Copy the public key and add it to GitHub.

- [ ] Clone this repo

- [ ] Install the packages
  - [ ] Cd to this repo and give permission to all script files
        `chmod +x scripts/*.sh`.
  - [ ] Run `./scripts/install.sh` script.

    This will place the dotfiles, download the packages and required fonts.

  - [ ] Download the packages that has to be downloaded manually
    - [ ] [vscode](https://code.visualstudio.com/download).
    - [ ] [zoom](https://zoom.us/download?os=linux).
    - [ ] [edge](https://www.microsoft.com/en-us/edge/download?form=MA13FJ).

- [ ] Install Gnome extensions.
  - [ ] Install
        [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/)
  - [ ] Install [Caffeine](https://extensions.gnome.org/extension/517/caffeine/)
  - [ ] Install
        [GSConnect](https://extensions.gnome.org/extension/1319/gsconnect/)
  - [ ] Install
        [Open Weather](https://extensions.gnome.org/extension/750/openweather/)
  - [ ] Install
        [Auto Select Headset](https://extensions.gnome.org/extension/3928/auto-select-headset/)

- [ ] Install ULauncher extensions.
  - [ ] Run `./scripts/install_extensions_requirements.sh`.
  - [ ] Install
        [Calculate Anything](https://github.com/tchar/ulauncher-albert-calculate-anything)
  - [ ] Install [Translate](https://github.com/manahter/ulauncher-translate)
  - [ ] Install
        [Files Fuzzy Search](https://github.com/hillaryychan/ulauncher-fzf)
  - [ ] Install [KeePassXC](https://github.com/pbkhrv/ulauncher-keepassxc)
  - [ ] Install
        [Password Generator](https://github.com/rkarami/ulauncher-password-generator)
  - [ ] Install
        [VSCode Recent](https://github.com/plibither8/ulauncher-vscode-recent)
  - [ ] Install
        [Notion Search](https://github.com/hakonmh/ulauncher-notion-search)
  - [ ] Install
        [Terminal Runner](https://ext.ulauncher.io/-/github-lighttigerxiv-ulauncher-terminal-runner-extension)
