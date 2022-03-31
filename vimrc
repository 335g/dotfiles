
set nocompatible

" encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp
scriptencoding utf-8

" indent
set autoindent
set backspace=indent,eol,start " バックスペースで何でも消す
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround " インデントをshiftwidthの倍数に丸める
set expandtab " タブの代わりにスペース

" 
set wrapscan " 最後まで検索したら先頭に戻る
set ruler " カーソルがある行列をハイライトする
set scrolloff=5 " スクロール時の余白
set vb t_vb= " ビープ音OFF
set shortmess& shortmess+=I "  起動時のメッセージを表示しない
set iminsert=0 imsearch=0 " 起動時のIMEをOFFにする
set hlsearch " 検索結果をハイライト
set incsearch " インクリメンタルサーチ
set helplang=ja,en " 日本語ヘルプを優先
set keywordprg=:help " カーソル下の単語をhelpで調べる
set clipboard=unnamed " クリップボードを使用する
set number " 行番号表示


let g:mapleader = "\<Space>" " Leaderキーをスペースに設定

" set rtp+=/usr/local/opt/fzf

call plug#begin('~/.vim/plugged')
Plug 'cocopon/iceberg.vim'                          " colorscheme {{{
Plug 'wadackel/vim-dogrun'
Plug 'dracula/vim'
Plug 'w0ng/vim-hybrid'
Plug 'altercation/vim-colors-solarized'
Plug 'cocopon/colorswatch.vim'
Plug 'cocopon/inspecthi.vim'
Plug 'dracula/vim'
Plug 'file:///Users/335g/dev/vim/lilac.vim'         "             }}}
Plug 'itchyny/lightline.vim'                        " statusline
Plug 'tpope/vim-fugitive'                           " git
Plug 'rust-lang/rust.vim'                           " rust
Plug 'prabirshrestha/vim-lsp'                       " LSP {{{
Plug 'dense-analysis/ale'
Plug 'rhysd/vim-lsp-ale'
Plug 'mattn/vim-lsp-settings'                       "     }}}
Plug 'junegunn/fzf', { 'do': './install --all' }    " Fuzzy Finder {{{
Plug 'junegunn/fzf.vim'                             "              }}}
Plug 'lambdalisue/fern.vim'                         " Filer {{{
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-comparator-lexical.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'       "       }}}
Plug 'vim-jp/vimdoc-ja'                             " help日本語化
Plug 'cohama/lexima.vim'                            " 括弧自動入力

"Plug 'vim-denops/denops.vim'
"  " DEBUG MODE : Disable when not needed
"  let g:denops#debug = 1

if has('nvim')
  Plug 'antoinemadec/FixCursorHold.nvim' " for fern.vim & neovim
    let g:cursorhold_updatetime = 100
endif

call plug#end()

set background=dark
colorscheme iceberg

filetype plugin indent on " ファイル形式毎のプラグインとインデントを有効にする
syntax enable " シンタックス有効化

" lightline {{{
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
" }}}

" inspecthi.vim
nnoremap <C-i> :Inspecthi<CR>


" rust.vim
let g:rustfmt_autosave = 1 " 保存時にrustfmtで自動整形

" fzf
let g:fzf_layout = { 'right': '80%' }
nnoremap <C-P> :Files<CR>

" vim-lsp {{{
function! s:rust_analyzer_apply_source_change(context) abort
    let command = get(a:context, 'command', {})

    let arguments = get(command, 'arguments', [])
    let argument = get(arguments, 0, {})

    let workspace_edit = get(argument, 'workspaceEdit', {})
    if !empty(workspace_edit)
        call lsp#utils#workspace_edit#apply_workspace_edit(workspace_edit)
    endif

    let cursor_position = get(argument, 'cursorPosition', {})
    if !empty(cursor_position)
        call cursor(lsp#utils#position#lsp_to_vim('%', cursor_position))
    endif
endfunction

function! s:rust_analyzer_run_single(context) abort
    let command = get(a:context, 'command', {})
    let arguments = get(command, 'arguments', [])
    let argument = get(arguments, 0, {})

    if !has_key(argument, 'kind')
        throw printf('Unsupported rust-analyzer.runSingle command. command=%s, arg=%s', string(command), string(argument))
    endif

    if argument['kind'] ==# 'cargo'
        let label = get(argument, 'label', 'cargo')
        let args = get(argument, 'args', {})
        let workspaceRoot = get(args, 'workspaceRoot', getcwd())
        let cargoArgs = get(args, 'cargoArgs', [])
        let cargoExtraArgs = get(args, 'cargoExtraArgs', [])
        let executableArgs = get(args, 'executableArgs', [])
        let cmd = ['cargo'] + cargoArgs + cargoExtraArgs

        if !empty(executableArgs)
            let cmd += ['--'] + executableArgs
        endif

        call term_start(cmd, {'cwd': workspaceRoot})
    else
        throw printf('unsupported rust-analyzer.runSingle command. command=%s, arg=%s', string(command), string(argument))
    endif
endfunction

function! s:setup_lsp() abort
    if executable('rust-analyzer')
        let config = {
        \   'name': 'rust-analyzer',
        \   'cmd': { server_info -> ['rust-analyzer'] },
        \   'allowlist': ['rust'],
        \ }
        if executable('cargo-clippy')
            let config.initialization_options = {
            \   'checkOnSave': { 'command': 'clippy' },
            \ }
        endif
        call lsp#register_server(config)
        call lsp#register_command('rust-analyzer.applySourceChange', function('s:rust_analyzer_apply_source_change'))
        call lsp#register_command('rust-analyzer.runSingle', function('s:rust_analyzer_run_single'))
    endif
endfunction


" }}}
