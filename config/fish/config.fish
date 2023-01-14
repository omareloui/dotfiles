set fish_greeting

set -Ux EDITOR nvim
set -Ux VISUAL nvim

set -Ux DOTFILES $HOME/dotfiles/config
set -Ux SYSTEM_SCRIPTS $HOME/scripts
set -Ux ZK_NOTEBOOK_DIR $HOME/zk


################################# KEY BINDINGS #################################
function fish_user_key_bindings
    fish_vi_key_bindings

    if test "$__fish_active_key_bindings" = fish_vi_key_bindings
        bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
    end
end


#################################### ALIASES ###################################
# alias vim="nvim"

# Moving {{{
alias ls="exa -l --no-time --icons --sort=type"

alias ll='ls -alF'
alias la='ls -a'
alias l='ls -CF'

alias ll="ls -lh"
alias lt="ls --human-readable --size -1 -S --classify"
# }}}

alias edge="/opt/microsoft/msedge/microsoft-edge"
alias browse="edge"

alias cv="open ~/Documents/Omar_Eloui_resume.pdf &"

alias h="history"
alias gh="history | grep" # Find a command in grep history

# Wifi {{{
alias wifiscan="$HOME/scripts/wifi/scan.sh"
alias wifiup="$HOME/scripts/wifi/connect.sh"
alias wifidown="$HOME/scripts/wifi/disconnect.sh"
alias wifimyconnection="$HOME/scripts/wifi/myconnect.sh"
# }}}

# Create python virtual environment
alias py="python3"
alias ve="python3 -m venv ./env"
alias va="source ./env/bin/activate.fish"

alias myip="curl ipinfo.io/ip; echo \\"

alias bat="batcat"

alias clipboard="xclip -sel clip"

alias w="variety -n"

alias dot="cd ~/dotfiles && neovide"
alias envim="cd ~/dotfiles/config/nvim && neovide"

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
alias gst="git status"
alias ga="git add"
alias gc="git cz"
alias gca=gitcommitall
alias guc="git uncommit"
alias gp=gitpush
alias gl="git l"

# Kitty
alias icat="kitty +kitten icat"

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

###################################### lua #####################################
set -gx LUA_PATH './?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;/home/omareloui/.luarocks/share/lua/5.1/?.lua;/home/omareloui/.luarocks/share/lua/5.1/?/init.lua'
set -gx LUA_CPATH './?.so;/usr/local/lib/lua/5.1/?.so;/usr/lib/x86_64-linux-gnu/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/home/omareloui/.luarocks/lib/lua/5.1/?.so'

###################################### go ######################################
set -gx PATH "/usr/local/go/bin:$PATH"

################################# init plugins #################################
zoxide init fish | source
starship init fish | source
