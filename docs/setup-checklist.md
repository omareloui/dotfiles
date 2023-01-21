# Checklist Setup

A checklist to follow to setup a new OS.

> This is an old checklist I made it before migrating to AwesomeWM. In the next
setup I'll update this file.

---

## 1. Git and Github

- [ ] create ssh key by running

  ```bash
  ssh-keygen -t rsa -b 4096 -C "omareloui@hotmail.com".
  ```

- [ ] copy the public key and add it to GitHub.
- [ ] clone this repo to `.dotfiles` in the home root.

  ```bash
  git clone git@github.com:omareloui/dotfiles.git ~/.dotfiles
  ```

## 2. Link the configurations and scripts

- [ ] cd into this repo and run
`./bootstrap/scripts.sh`, `./bootstrap/config.sh`, and `./bootstrap/battery.sh`.

  ```bash
  cd ~/.dotfiles/
  ./bootstrap/scripts.sh
  ./bootstrap/config.sh
  ./bootstrap/battery.sh
  ```

## 3. Packages

- [ ] open the packages install script and comment out the packages that you
  don't want to download and run the file

  ```bash
  vi ./bootstrap/packages/index.sh

  # After making sure everything is okay run
  ./bootstrap/packages/index.sh
  ```

- [ ] Download the packages that has to be downloaded manually
  - [ ] [vscode](https://code.visualstudio.com/download).
  - [ ] [zoom](https://zoom.us/download?os=linux).
  - [ ] [edge](https://www.microsoft.com/en-us/edge/download?form=MA13FJ).

## 4. Gnome extensions

Gnome extensions to add.

- [ ] [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/)
- [ ] [Caffeine](https://extensions.gnome.org/extension/517/caffeine/)
- [ ] [GSConnect](https://extensions.gnome.org/extension/1319/gsconnect/)
- [ ] [Open Weather](https://extensions.gnome.org/extension/750/openweather/)
- [ ] [Auto Select Headset](https://extensions.gnome.org/extension/3928/auto-select-headset/)

## 5. ULauncher extensions

Extensions I use for ULauncher.

- [ ] [Calculate Anything](https://github.com/tchar/ulauncher-albert-calculate-anything).
- [ ] [Translate](https://github.com/manahter/ulauncher-translate).
- [ ] [Files Fuzzy Search](https://github.com/hillaryychan/ulauncher-fzf).
- [ ] [KeePassXC](https://github.com/pbkhrv/ulauncher-keepassxc).
- [ ] [Password Generator](https://github.com/rkarami/ulauncher-password-generator).
- [ ] [VSCode Recent](https://github.com/plibither8/ulauncher-vscode-recent).
- [ ] [Notion Search](https://github.com/hakonmh/ulauncher-notion-search).
- [ ] [Terminal Runner](https://ext.ulauncher.io/-/github-lighttigerxiv-ulauncher-terminal-runner-extension).
