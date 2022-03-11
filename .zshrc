
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
# history
####################################################

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups     # 前と重複する行は記録しない
setopt hist_ignore_all_dups # 重複したhistoryは追加しない
setopt share_history        # 同時に起動したzshの間でヒストリを共有する
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに保存する
setopt auto_pushd           # cdしたらpushd
setopt auto_list            # 補完候補が複数ある時に一覧表示
setopt auto_menu            # 補完候補が複数ある時に自動的に一覧表示する
setopt no_beep              #
setopt HIST_IGNORE_SPACE    # 行頭がスペースのコマンドは記録しない
setopt HIST_IGNORE_ALL_DUPS # 履歴中の重複行をファイル記録前に無くす
setopt HIST_FIND_NO_DUPS    # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_NO_STORE        # histroyコマンドは記録しない
zshaddhistory() {
    local line=${1%%$'\n'} #コマンドライン全体から改行を除去したもの
    local cmd=${line%% *}  # １つ目のコマンド
    # 以下の条件をすべて満たすものだけをヒストリに追加する
    [[ ${#line} -ge 5
         && ${cmd} != (l|l[sal])
         && ${cmd} != (cd)
         && ${cmd} != (m|man)
         && ${cmd} != (r[mr])
    ]]
}

####################################################
# alias
####################################################

alias vi=vim
alias la='ls -a'
alias lf='ls -f'
alias ll='ls -l'
alias lal='ls -al'
# alias mv='nocorrect mv'
# alias cp='nocorrect cp'
# alias mkdir='nocorrect mkdir'
alias where='command -v'
alias e='exa'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/335g/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/335g/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/335g/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/335g/google-cloud-sdk/completion.zsh.inc'; fi
