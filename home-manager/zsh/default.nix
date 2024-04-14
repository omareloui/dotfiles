{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    localVariables = {
      ZVM_VI_INSERT_ESCAPE_BINDKEY = "jk";
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
