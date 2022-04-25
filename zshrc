
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


# Neovim 起動速度計測
function nvim-startuptime() {
  local file=$1
  local total_msec=0
  local msec
  local i
  for i in $(seq 1 10); do
    msec=$({(TIMEFMT='%mE'; time nvim --headless -c q $file ) 2>&3;} 3>/dev/stdout >/dev/null)
    msec=$(echo $msec | tr -d "ms")
    echo "${(l:2:)i}: ${msec} [ms]"
    total_msec=$(( $total_msec + $msec ))
  done
  local average_msec
  average_msec=$(( ${total_msec} / 10 ))
  echo "\naverage: ${average_msec} [ms]"
}

function nvim-startuptime-slower-than-default() {
  local file=$1
  local time_file_rc
  time_file_rc=$(mktemp --suffix "_nvim_startuptime_rc.txt")
  local time_rc
  time_rc=$(nvim --headless --startuptime ${time_file_rc} -c "quit" $file > /dev/null && tail -n 1 ${time_file_rc} | cut -d " " -f1)

  local time_file_norc
  time_file_norc=$(mktemp --suffix "_nvim_startuptime_norc.txt")
  local time_norc
  time_norc=$(nvim --headless --noplugin -u NONE --startuptime ${time_file_norc} -c "quit" $file > /dev/null && tail -n 1 ${time_file_norc} | cut -d " " -f1)

  echo "my vimrc: ${time_rc}s\ndefault neovim: ${time_norc}s\n"
  local result
  result=$(scale=3 echo "${time_rc} / ${time_norc}" | bc)
  echo "${result}x slower your Neovim than the default."
}

function nvim-profiler() {
  local file=$1
  local time_file
  time_file=$(mktemp --suffix "_nvim_startuptime.txt")
  echo "output: $time_file"
  time nvim --headless --startuptime $time_file -c q $file
  tail -n 1 $time_file | cut -d " " -f1 | tr -d "\n" && echo " [ms]\n"
  cat $time_file | sort -n -k 2 | tail -n 20
}
