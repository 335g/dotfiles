
let g:mapleader = "\<Space>" " Leaderキーをスペースに設定

" {{{ dein
let s:dein_dir = has('nvim') ? expand('~/.cache/dein/nvim') : expand('~/.cache/dein/vim')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " {{{ plugins
  call dein#add('cocopon/iceberg.vim')    " colorscheme
  call dein#add('itchyny/lightline.vim')  " light and configurable statusline/tabline
  call dein#add('tpope/vim-fugitive')     " git wrapper 
  " }}}

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

function! DeinClean() abort
  let s:removed_plugins = dein#check_clean()
  if len(s:removed_plugins) > 0
    echom s:removed_plugins
    call map(s:removed_plugins, "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
  endif
endfunction

command! CleanPlugins call DeinClean()
" }}}

" シンタックス有効化
syntax enable

" ファイル形式毎のプラグインとインデントを有効にする
filetype plugin indent on

" lightline {{{
let g:lightline = {
  \   'colorscheme': 'wombat',
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
" }}}

" カラースキーム {{{
colorscheme iceberg
" }}}


" オプション {{{
set autoindent      " 改行時に前の行のインデントを継続する
set background=dark " 背景色
set encoding=utf-8  " 文字コード: UTF8
set expandtab       " タブ->空白
set laststatus=2    " 最終行にステータスラインを追加する
set noshowmode      " 一番下の --INSERT -- 等を非表示にする
set number          " 行番号
set shiftwidth=4    " 自動インデント幅
set smartindent     " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set softtabstop=2   " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅（デフォルトでは無効: 0）
set tabstop=4       " タブ幅

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


" キーマップ {{{

" vimrc読み込み
nnoremap <Leader>. :new ~/.vimrc<CR>
nnoremap <Leader>s :exe "source" expand("%")<CR>


" }}}
