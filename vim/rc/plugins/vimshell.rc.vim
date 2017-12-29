
"-------------------------
" vimshell.vim
"

let g:vimshell_right_prompt = 
    \ 'gita#statusline#format("%{|/}ln%lb%{ <> |}rn%{/|}rb")'
let g:vimshell_prompt = '% '
let g:vimshwll_force_overwrite_statusline = 1
let g:vimshwll_external_history_path = expand('~/.zsh-history')

