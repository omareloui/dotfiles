# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=100000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/omareloui/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# bind jk to exit insert mode
bindkey -M viins 'jk' vi-cmd-mode

# set the cursor in normal/insert modes
export VI_MODE_SET_CURSOR=true

################################## my scripts ##################################
export PATH="$HOME/.local/bin:$PATH"

##################################### pnpm #####################################
# set -gx PNPM_HOME "/home/omareloui/.local/share/pnpm"
# set -gx PATH "$PNPM_HOME" $PATH

##################################### deno #####################################
export PATH="$HOME/.deno/bin:$PATH"

##################################### rust #####################################
export PATH="$HOME/.cargo/bin:$PATH"

###################################### lua #####################################
# set -gx LUA_PATH './?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;/home/omareloui/.luarocks/share/lua/5.1/?.lua;/home/omareloui/.luarocks/share/lua/5.1/?/init.lua'
# set -gx LUA_CPATH './?.so;/usr/local/lib/lua/5.1/?.so;/usr/lib/x86_64-linux-gnu/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/home/omareloui/.luarocks/lib/lua/5.1/?.so'

###################################### go ######################################
# set -gx PATH "/usr/local/go/bin:$PATH"

# start starfish
eval "$(starship init zsh)"

# start zoxide
eval "$(zoxide init zsh)"
