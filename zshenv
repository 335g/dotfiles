export EDITOR=vim
export SHELL=zsh
export LANG=en_US.UTF-8
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/Library/Python/3.9/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export STARSHIP_CACHE=~/.starship/cache
export XDG_CONFIG_HOME=$HOME/.config
export FZF_DEFAULT_OPTS='--height=50% --layout=reverse --inline-info --preview "bat --color=always --style=header,grid --line-range=:100 {}"'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
