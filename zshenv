export EDITOR=vim
export SHELL=/bin/zsh
export LANG=en_US.UTF-8
export STARSHIP_CACHE=~/.starship/cache
export FZF_DEFAULT_OPTS='--height=50% --layout=reverse --inline-info --preview "bat --color=always --style=header,grid --line-range=:100 {}"'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/.rye/shims:$PATH
export PATH=$HOME/.deno/bin:$PATH
