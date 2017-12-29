
" <TAB>: completion
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#manual_complete()

function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction"}}}

" <S-TAB>: completion back
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "c\<C-h>"

" <C-h>, <BS>: close popup and delete backword char
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

" <C-l>: regorously evaluate candidates
inoremap <silent><expr><C-l> deoplete#complete_common_string()

" <CR>: cancel and go to the next line
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#cancel_popup() . "\<CR>"
endfunction

" ': select the candidates
inoremap <expr> ' pumvisible() ? deoplete#close_popup() : "'"
