while read file
do 
  source "$ZDOTDIR/$file.zsh"
done <<-EOF
env
options
plugins
keybindings
aliases
utils
EOF
