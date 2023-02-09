# Aliases

alias zshconfig="$EDITOR ~/.config/zsh/.zshrc"

alias ls="exa -l --no-time --icons --sort=type"

alias ll='ls -alF'
alias la='ls -a'
alias l='ls -CF'

alias ll="ls -lh"
alias lt="ls --human-readable --size -1 -S --classify"

alias neovide="env -u WAYLAND_DISPLAY neovide"

alias py="python3"
alias ve="python3 -m venv ./env"
alias va="source ./env/bin/activate"

alias q="exit"
alias :q="exit"

alias cat="bat --color always --plain"
alias grep="grep --color=auto"