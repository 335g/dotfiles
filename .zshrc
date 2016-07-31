
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

###################################################
# zplug
###################################################

[[ -f $HOME/.zplug/zplug ]] || return

source $HOME/.zplug/zplug


zplug "rimraf/k"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "b4b4r07/auto-fu.zsh"
zplug "b4b4r07/enhancd", use:init.sh


# installation check => install
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load

####################################################
# visualizaion
####################################################

autoload -U colors
colors

PROMPT=$'[%*] → '
RPROMPT=$'`branch-status-check` %~'
setopt prompt_subst

function branch-status-check {
    local prefix branchname suffix
        # .gitの中だから除外
        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
            return
        fi
        branchname=`get-branch-name`
        # ブランチ名が無いので除外
        if [[ -z $branchname ]]; then
            return
        fi
        prefix=`get-branch-status` #色だけ返ってくる
        suffix='%{'${reset_color}'%}'
        echo ${prefix}${branchname}${suffix}
}
function get-branch-name {
    # gitディレクトリじゃない場合のエラーは捨てます
    echo `git rev-parse --abbrev-ref HEAD 2> /dev/null`
}
function get-branch-status {
    local res color
        output=`git status --short 2> /dev/null`
        if [ -z "$output" ]; then
            res=':' # status Clean
            color='%{'${fg[green]}'%}'
        elif [[ $output =~ "[\n]?\?\? " ]]; then
            res='?:' # Untracked
            color='%{'${fg[yellow]}'%}'
        elif [[ $output =~ "[\n]? M " ]]; then
            res='M:' # Modified
            color='%{'${fg[red]}'%}'
        else
            res='A:' # Added to commit
            color='%{'${fg[cyan]}'%}'
        fi
        # echo ${color}${res}'%{'${reset_color}'%}'
        echo ${color} # 色だけ返す
}

####################################################
# alias
####################################################

alias vi=vim
alias vim=/usr/local/bin/vim
alias la='ls -a'
alias lf='ls -f'
alias ll='ls -l'
alias lal='ls -al'
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias where='command -v'
