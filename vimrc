
let g:mapleader = "\<Space>" " Leaderキーをスペースに設定

set rtp+=/usr/local/opt/fzf

call plug#begin('~/.vim/plugged')
" my plugins
"Plug '~/dev/vim/session.vim'

" colors
Plug 'cocopon/iceberg.vim'
Plug 'cocopon/colorswatch.vim'
Plug 'cocopon/inspecthi.vim'
  nnoremap <C-i> :Inspecthi<CR>
Plug 'dracula/vim'
Plug 'file:///Users/335g/dev/vim/lilac.vim'

function! s:auto_update_colorscheme(...) abort
    if &ft !=# 'vim'
        echoerr 'Execute this command in colorscheme file buffer'
    endif
    setlocal autoread noswapfile
    let interval = a:0 > 0 ? a:1 : 3000
    let timer = timer_start(interval, {-> execute('checktime')}, {'repeat' : -1})
    autocmd! BufReadPost <buffer> source %
endfunction

" ### Function only during develpment of colorscheme.
command! -nargs=? AutoUpdateColorscheme call <SID>auto_update_colorscheme(<f-args>)

" statusline
Plug 'itchyny/lightline.vim'
  let g:lightline = {
    \   'colorscheme': 'iceberg',
    \   'active': {
    \     'left': [
    \       ['mode', 'paste'],
    \       ['readonly', 'gitbranch', 'filepath', 'modified']
    \     ]
    \   },
    \   'component_function':{
    \     'filepath': 'FilePath',
    \     'gitbranch': 'FugitiveHead',
    \   },
    \ }
  
  function! FilePath()
    if winwidth(0) > 90
      return expand("%:s")
    else
      return expand("%:t")
    endif
  endfunction

" git
Plug 'tpope/vim-fugitive'
  nmap     <Leader>g :Git<CR>gg<c-n>
  nnoremap <Leader>d :Gdiff<CR>

" rust
Plug 'rust-lang/rust.vim'
  " 保存時にrustfmtで自動整形
  let g:rustfmt_autosave = 1

Plug 'neoclide/coc.nvim', {'branch': 'release' }
  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif
  
  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  
  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  
  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  
  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction
  
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  let g:fzf_layout = { 'right': '80%' }
  nnoremap <C-P> :Files<CR>

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-comparator-lexical.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

"Plug 'vim-denops/denops.vim'
"  " DEBUG MODE : Disable when not needed
"  let g:denops#debug = 1
"Plug 'vim-denops/denops-helloworld.vim'

if has('nvim')
  Plug 'antoinemadec/FixCursorHold.nvim' " for fern.vim & neovim
    let g:cursorhold_updatetime = 100

endif

" syntax
"Plug 'sheerun/vim-polyglot'
Plug 'leafgarland/typescript-vim'

" help
Plug 'vim-jp/vimdoc-ja'

call plug#end()

" rust-analyzer inline hint
autocmd VimEnter,ColorScheme * highlight link CocHintSign Comment

colorscheme iceberg


" オプション {{{
syntax enable " シンタックス有効化
filetype plugin indent on " ファイル形式毎のプラグインとインデントを有効にする

set autoindent                                " 改行時に前の行のインデントを継続する
set background=dark                           " 背景色
set encoding=UTF-8                            " 文字コード: UTF8
set expandtab                                 " タブ->空白
set helplang=ja,en                            " ヘルプはデフォルトで日本語
set guifont=HackGenNerdConsole-Regular,Monaco " font
set laststatus=2                              " 最終行にステータスラインを追加する
set noshowmode                                " 一番下の --INSERT -- 等を非表示にする
set number                                    " 行番号
set shell=zsh                                 " ターミナルモードのシェル
set shiftwidth=4                              " 自動インデント幅
set smartindent                               " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set softtabstop=2                             " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅（デフォルトでは無効: 0）
set tabstop=4                                 " タブ幅

" インデント
augroup fileTypeIndent
  au!
  au FileType go setlocal tabstop=4 shiftwidth=4
  au FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType php setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType vue  setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType sh setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType fish setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType zsh setlocal tabstop=2 shiftwidth=2 expandtab
  au FileType rust setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
  au FileType markdown setlocal tabstop=2 shiftwidth=2 expandtab
augroup END
" }}}

" Other

" VimShowHlGroup: Show highlight group name under a cursor
command! VimShowHlGroup echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')

" VimShowHlItem: Show highlight item name under a cursor
command! VimShowHlItem echo synIDattr(synID(line("."), col("."), 1), "name")

