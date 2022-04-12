
if &compatible
    set nocompatible
endif

" encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp
scriptencoding utf-8

let g:mapleader = "\<Space>" " Leaderキーをスペースに設定

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
set iminsert=0 imsearch=0 " 起動時のIMEをOFFにする
set hlsearch " 検索結果をハイライト
set incsearch " インクリメンタルサーチ
set helplang=ja,en " 日本語ヘルプを優先
set keywordprg=:help " カーソル下の単語をhelpで調べる
set number " 行番号表示
set fileformats=unix,dos,mac " 改行コード
set noshowcmd " コマンド表示なし
set history=100 " コマンド履歴
set showmatch " 対応する括弧に僅かの間ジャンプする
set matchtime=1 " ジャンプ時間
set matchpairs+=<:> " 対応する括弧の強調表示
set updatetime=300 " udpate-time[ms] for CursorHold
set shortmess+=c

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'sidebar-nvim/sidebar.nvim'
Plug 'goolord/alpha-nvim'
Plug 'petertriho/nvim-scrollbar'
Plug 'kevinhwang91/nvim-hlslens'

Plug 'cohama/lexima.vim'
"Plug 'itchyny/lightline.vim'
Plug 'vim-jp/vimdoc-ja'

Plug 'tpope/vim-fugitive'
Plug 'rust-lang/rust.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'tamago324/nlsp-settings.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-cmdline'
Plug 'ray-x/cmp-treesitter'
Plug 'simrat39/rust-tools.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'folke/trouble.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'mvllow/modes.nvim'

Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'yioneko/nvim-yati'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'SmiteshP/nvim-gps'

" for all colorscheme work
Plug 'cocopon/colorswatch.vim'
Plug 'cocopon/inspecthi.vim'
Plug 'folke/tokyonight.nvim'

" colorschemes
Plug 'cocopon/iceberg.vim'
" Plug 'wadackel/vim-dogrun'
" Plug 'dracula/vim'


call plug#end()

filetype plugin indent on " ファイル形式毎のプラグインとインデントを有効にする
syntax enable " シンタックス有効化

set background=dark
colorscheme iceberg

" rust.vim
let g:rustfmt_autosave = 1

" inspecthi.vim
nnoremap <C-i> :Inspecthi<CR>

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>

" telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>

" Quick-fix
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Show diagnostic popup on cursor hover
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Goto prev/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

lua <<EOF
-- Note: `vim.opt.cursorline` must be set to true for lines to be hightlighted
-- with `mvllow/modes.nvim`
vim.opt.cursorline = true

require('alpha').setup(require('alpha.themes.startify').config)

local colors = require('tokyonight.colors').setup {}
require('scrollbar').setup {
    handle = {
        color = colors.bg_highlight,
    },
    marks = {
        Search = { color = colors.orange },
        Error = { color = colors.error },
        Warn = { color = colors.warning },
        Info = { color = colors.info },
        Hint = { color = colors.hint },
        Misc = { color = colors.purple },
    }
}
require('hlslens').setup {
    calm_down = true,
    nearest_only = true,
    nearest_float_when = 'always'
}
require('scrollbar.handlers.search').setup {}
require('lualine').setup {
    options = {
        theme= 'iceberg_dark',
    },
}
require('sidebar-nvim').setup {
    open = true,
    initial_width = 30,
    sections = {
        "datetime",
        "git",
        "diagnostics",
    },
}
require('nvim-gps').setup {}
require('fidget').setup {}
require('trouble').setup {}
require('todo-comments').setup {}
require('modes').setup {}
require('rust-tools').setup {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        runnables = {
            use_telescope = true
        },
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

local cmp = require'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        })
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp_document_symnol' },
        { name = 'treesitter' },
        { name = 'cmdline' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'nvim_lua' },
    },
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.clangd.setup {
  capabilities = capabilities,
}

require("nvim-treesitter.configs").setup {
    yati = { enable = true },
    context_commentstring = { enable = true },
}
EOF
