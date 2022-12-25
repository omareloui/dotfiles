set fish_greeting

set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux DOTFILES $HOME/dotfiles/config


################################# KEY BINDINGS #################################
function fish_user_key_bindings
    fish_vi_key_bindings

    if test "$__fish_active_key_bindings" = fish_vi_key_bindings
        bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
    end
end


#################################### ALIASES ###################################
alias vim="nvim"

# Moving
alias ls="exa -l --no-time --icons --sort=type"

alias ll='ls -alF'
alias la='ls -a'
alias l='ls -CF'

alias ll="ls -lh"
alias lt="ls --human-readable --size -1 -S --classify"
# End Moving

alias edge="/opt/microsoft/msedge/microsoft-edge"
alias browse="edge"

alias h="history"
alias gh="history | grep" # Find a command in grep history

# Create python virtual environment
alias py="python3"
alias ve="python3 -m venv ./env"
alias va="source ./env/bin/activate.fish"

alias myip="curl ipinfo.io/ip; echo \\"

alias bat="batcat"

alias clipboard="xclip -sel clip"

alias w="variety -n"

# Git
function gitcommitall
    git add .
    git cz
end

function gitpush
    git pull
    git push
end

alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git cz"
alias gca=gitcommitall
alias guc="git uncommit"
alias gp=gitpush
alias gl="git l"


# Fun
alias matrix="cmatrix -C blue"

########################## set the cursor for vi modes #########################
function set_mode_pre_execution --on-event fish_preexec
    set command (expr $argv : '\([^ ]*\).*')
    set -g __last_fish_bind_mode $fish_bind_mode

    set -g fish_bind_mode insert

    fish_vi_cursor
end

function set_mode_post_execution --on-event fish_postexec
    set temp $__last_fish_bind_mode
    set -e __last_fish_bind_mode
    set -g fish_bind_mode $temp
    fish_vi_cursor
end

set -x fish_cursor_default block
set -x fish_cursor_visual block
set -x fish_cursor_insert line
set -x fish_cursor_replace_one underscore


##################################### pnpm #####################################
set -gx PNPM_HOME "/home/omareloui/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

##################################### deno #####################################
set -gx DENO_INSTALL "/home/omareloui/.deno"
set -gx PATH "$DENO_INSTALL/bin:$PATH"

##################################### rust #####################################
set -gx PATH "$HOME/.cargo/bin:$PATH"

################################# init plugins #################################
zoxide init fish | source
starship init fish | source
