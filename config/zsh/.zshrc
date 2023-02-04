# PATH
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.deno/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Global variables
export LANG=en_US.UTF-8

export VISUAL="nvim"
export EDITOR="nvim"

export DOTFILES=$HOME/.dotfiles
export DOTFILES_ASSETS=$DOTFILES/assets
export DOTFILES_CONFIG=$DOTFILES/config
export SCRIPTS=$DOTFILES/scripts
export BOOTSTRAP_FILES=$DOTFILES/bootstrap

export REPOS_DIR=$HOME/repos
export ZK_NOTEBOOK_DIR=$HOME/zk

export MUSIC_DIR=$HOME/Music
export MOVIES_DIR=$HOME/Movies

# History settings
export HISTFILE=~/.cache/zsh/zsh_history
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export HISTTIMEFORMAT="[%F %T] "

setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS


### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # insenstive completion
### End of Zinit's installer chunk

# Required by zinit
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust


# Plugins
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit light jeffreytse/zsh-vi-mode


### Plugins configs
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# run this to configure the theme for syntax highlighting
# fast-theme base16

# Bindings
# bindkey '^ ' autosuggest-accept

# Aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

alias ls="exa -l --no-time --icons --sort=type"

alias ll='ls -alF'
alias la='ls -a'
alias l='ls -CF'

alias ll="ls -lh"
alias lt="ls --human-readable --size -1 -S --classify"

alias neovide="env -u WAYLAND_DISPLAY neovide"

# Functions
extract() {
  case $1 in
    *.tar.bz | *.tar.bz2 | *.tar.tbz | *.tar.tbz2)
      foldername="$(basename "${1%%.*}")"
      [[ ! -d $foldername ]] && mkdir $foldername
      tar xjvf "$1" -C "$foldername"
      ;;
    *.tar.gz | *.tar.tgz)
      foldername="$(basename "${1%%.*}")"
      [[ ! -d $foldername ]] && mkdir $foldername
      tar xzvf "$1" -C "$foldername"
      ;;
    *.tar.xz | *.tar.txz)
      foldername="$(basename "${1%%.*}")"
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


### Init plugins
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(thefuck --alias)"
