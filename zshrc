
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

#alias vi=vim
#alias la='ls -a'
#alias lf='ls -f'
#alias ll='ls -l'
#alias lal='ls -al'
#alias where='command -v'
alias e='exa'
alias ctags="`brew --prefix`/bin/ctags"

####################################################
# other
####################################################

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/335g/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/335g/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/335g/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/335g/google-cloud-sdk/completion.zsh.inc'; fi

# customize prompt by starship
eval "$(starship init zsh)" for starship

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
