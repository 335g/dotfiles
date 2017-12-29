
let g:neocomplete#disable_auto_complete = 0
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_camel_case = 1

let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#manual_completion_start_length = 0
let g:neocomplete#min_keyword_length = 3
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_cursor_hold_i = 0

let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#max_list = 100

" <C-f>, <C-b> : move
inoremap <expr><C-f> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr><C-b> pumvisible() ? "\<PageUp>" : "\<Left>"

" <C-h>, <BS> : close popup and delete backword char
inoremap <expr> <C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr> <BS>  neocomplete#smart_close_popup()."\<C-h>"

" <C-n> : neocomplete
inoremap <expr> <C-n> pumvisible() ? "<\<C-n>" : "\<C-x>\<C-u>\<C-p>\<Down>"

" <C-p> : keyword completion
inoremap <expr> <C-p> pumvisible() ? "<\C-p>" : "\<C-p>\<C-n>"

" <C-g> : undo completion
inoremap <expr> <C-g> neocomplete#undo_completion()

" <TAB> : completion
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ neocomplete#start_manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction"}}}

" <S-TAB> : completion back
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


