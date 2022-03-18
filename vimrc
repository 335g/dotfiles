
let g:mapleader = "\<Space>" " Leaderキーをスペースに設定

call plug#begin('~/.vim/plugged')

" colors
Plug 'cocopon/iceberg.vim', {'do': 'cp colors/* ~/.vim/colors/'}
Plug 'dracula/vim', {'do': 'cp colors/* ~/.vim/colors/'}

Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
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

" git
Plug 'tpope/vim-fugitive'
  nmap     <Leader>g :Git<CR>gg<c-n>
  nnoremap <Leader>d :Gdiff<CR>
Plug 'rhysd/git-messenger.vim'

Plug 'rust-lang/rust.vim'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  let g:fzf_layout = { 'down': '30%' }
  nnoremap <C-P> :Files<CR>

Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install() }}
Plug 'mattn/emmet-vim'
Plug 'markonm/traces.vim' " 置換プレビュー
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'vim-jp/vimdoc-ja'

call plug#end()

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


" キーマップ {{{

" vimrc読み込み
nnoremap <Leader>. :new ~/.vimrc<CR>
nnoremap <Leader>s :exe "source" expand("%")<CR>

" fzf
nnoremap <C-P> :Files<CR>
" }}}
