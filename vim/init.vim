
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
set completeopt=menu,menuone,noselect

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

call plug#begin('~/.vim/plugged')
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Statusline --------------------
Plug 'nvim-lualine/lualine.nvim'
Plug 'SmiteshP/nvim-gps'

" LSP ---------------------------
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'tamago324/nlsp-settings.nvim'

" View --------------------------
Plug 'j-hui/fidget.nvim'

" Auto Completion --------------------
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-emoji'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'ray-x/cmp-treesitter'

" Snippet
Plug 'L3MON4D3/LuaSnip'
Plug 'kevinhwang91/nvim-hclipboard'
Plug 'rafamadriz/friendly-snippets'

" Programming Language Specific
Plug 'simrat39/rust-tools.nvim'

" Color -------------------
Plug 'folke/lsp-colors.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'EdenEast/nightfox.nvim'
Plug 'cocopon/iceberg.vim'

call plug#end()

filetype plugin indent on " ファイル形式毎のプラグインとインデントを有効にする
syntax enable " シンタックス有効化

" Enable true color
"if exists('+termguicolors') && !has('gui_running')
"    set termguicolors
"endif

set background=dark
colorscheme iceberg


lua <<EOF
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'buffer' },
        { name = 'luasnip' },
        { name = 'emoji', insert = true },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp_document_symbol' }
    }, {
        { name = 'buffer' },
        { name = 'treesitter' },
    },
})

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "nvim_lsp_document_symbol" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline(":", {
	mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "c" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "c" }),
		["<C-y>"] = {
			c = cmp.mapping.confirm({ select = false }),
		},
		["<C-q>"] = {
			c = cmp.mapping.abort(),
		},
	},
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

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

require('lualine').setup {
    options = {
        theme= 'iceberg_dark',
    },
}
require('nvim-gps').setup {}
require('fidget').setup {}
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
    server = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
           }
        }
    },
} 
EOF
