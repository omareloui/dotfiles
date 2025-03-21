{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    localVariables = {
      ZSH_AUTOSUGGEST_STRATEGY = ["history" "completion"];
    };
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      ignorePatterns = ["*.private*"];
      path = "${config.xdg.cacheHome}/zsh/zsh_history";
      save = 1000000000;
      size = 1000000000;
    };
    initExtraFirst = "";
    initExtraBeforeCompInit = "";

    initExtra =
      /*
      bash
      */
      ''
        bindkey '^ ' autosuggest-accept
        extract() {
          case $1 in
            *.tar.xz.gpg|*.txz.gpg)
              foldername="$(basename "''${1%%.*}")"
              [[ ! -d foldername ]] && mkdir $foldername
              gpg -d "$file" | tar xJvC "$foldername"
            ;;
            *.tar.bz | *.tar.bz2 | *.tar.tbz | *.tar.tbz2)
              foldername="$(basename "''${1%%.*}")"
              [[ ! -d $foldername ]] && mkdir $foldername
              tar xjvf "$1" -C "$foldername"
              ;;
            *.tar.gz | *.tar.tgz)
              foldername="$(basename "''${1%%.*}")"
              [[ ! -d $foldername ]] && mkdir $foldername
              tar xzvf "$1" -C "$foldername"
              ;;
            *.tar.xz | *.tar.txz)
              foldername="$(basename "''${1%%.*}")"
              [[ ! -d $foldername ]] && mkdir $foldername
              tar xJvf "$1" -C "$foldername"
              ;;
            *.zip)
              unzip "$1"
              ;;
            *.rar)
              unrar x "$1"
              ;;
            *.7z)
              7z x "$1"
              ;;
            *)
              echo -e "\e[31mError\e[33m:\e[0m Didn't find a function to exctract $1"
              ;;
          esac
        }

        function ya() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
          ${lib.getExe pkgs.yazi} "$@" --cwd-file="$tmp"
          if cwd="$(\cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            cd -- "$cwd"
          fi
          rm -f -- "$tmp"
        }

        function _list_zellij_sessions () {
          zellij list-sessions 2>/dev/null | sed -e 's/\x1b\[[0-9;]*m//g'
        }

        function zja() {
          zj_session=$(_list_zellij_sessions | rg -v '(EXITED -|\(current\))' | awk '{print $1}' | fzf)
          if [[ -n $zj_session ]]; then
            wezterm start -- zsh --login -c "zellij attach $session"
          fi
        }

        function zjl() {
          layout=$(fd '.*' "$HOME/.config/zellij/layouts" | xargs -I{} basename {} .kdl | fzf)
          if [[ -n $layout ]]; then
            wezterm start -- zsh --login -c "zellij --layout $layout attach -c $layout"
          fi
        }

        function zjgc() {
          sessions=$(_list_zellij_sessions | awk '/EXITED -/ {print $1}' )
          if [[ -n $sessions ]]; then
            echo $sessions | xargs -n1 zellij d
          fi
        }

        function zjd() {
          sessions=$(_list_zellij_sessions | awk '{print $1}' | fzf -m)
          if [[ -n $sessions ]]; then
            echo $sessions | xargs -n1 zellij d --force
          fi
        }

        hash -d h="$HOME/myhome"
        hash -d d="$HOME/.dotfiles"
      '';

    prezto = {
      enable = true;
      caseSensitive = false;
      editor = {
        keymap = "vi";
        promptContext = true;
      };
      pmodules = [
        "completion"
        "directory"
        "editor"
        "environment"
        "git"
        "history"
        "prompt"
        "spectrum"
        "terminal"
        "utility"
      ];
      terminal.autoTitle = true;
    };

    zplug = {
      enable = true;
      plugins = [
        {name = "zsh-users/zsh-autosuggestions";}
        {name = "zsh-users/zsh-completions";}
        {name = "jeffreytse/zsh-vi-mode";}
        {name = "zdharma-continuum/fast-syntax-highlighting";}
      ];
    };
  };
}
