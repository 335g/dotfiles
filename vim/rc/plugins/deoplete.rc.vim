
set completeopt+=noinsert

let g:deoplete#enable_refresh_always = 1
let g:deoplete#enable_camel_case = 1


" <TAB> : completion
imap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ deopelete#mapping#manual_complete()

function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction"}}}

" <S-TAB> : completion back
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


