
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
set cursorline " カーソル行をハイライトする
set confirm " 終了時に保存されてない場合保存するか聞いてくれる

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menu,menuone,noselect

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" true color
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors

call plug#begin('~/.vim/plugged')
" Lua
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'tami5/sqlite.lua'
Plug 'MunifTanjim/nui.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Filer
Plug 'nvim-neo-tree/neo-tree.nvim', {'branch': 'v2.x'}

" Statusline --------------------
Plug 'nvim-lualine/lualine.nvim'
Plug 'SmiteshP/nvim-gps'

" LSP ---------------------------
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'tamago324/nlsp-settings.nvim'

" View --------------------------
Plug 'j-hui/fidget.nvim'
Plug 'goolord/alpha-nvim'
Plug 'petertriho/nvim-scrollbar'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'

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

" FuzzyFinder ------------------
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'

" Snippet
Plug 'L3MON4D3/LuaSnip'
Plug 'kevinhwang91/nvim-hclipboard'
Plug 'rafamadriz/friendly-snippets'

" Git
Plug 'TimUntersberger/neogit'
Plug 'rhysd/committia.vim'
Plug 'lewis6991/gitsigns.nvim'

" Operation
Plug 'phaazon/hop.nvim'
Plug 'haya14busa/vim-edgemotion'
Plug 'yutkat/wb-only-current-line.vim'
Plug 'machakann/vim-sandwich'
Plug 'windwp/nvim-autopairs'
Plug 'andymass/vim-matchup'
Plug 'ntpeters/vim-better-whitespace'

" Search
Plug 'kevinhwang91/nvim-hlslens'

" Programming Language Specific
Plug 'simrat39/rust-tools.nvim'
Plug 'saecki/crates.nvim', { 'tag': 'v0.2.1' }

" Color -------------------
Plug 'norcalli/nvim-colorizer.lua'
Plug 'folke/lsp-colors.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'mvllow/modes.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'EdenEast/nightfox.nvim'
Plug 'cocopon/iceberg.vim'
Plug 'dracula/vim'

call plug#end()

filetype plugin indent on " ファイル形式毎のプラグインとインデントを有効にする
syntax enable " シンタックス有効化

set background=dark

let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = ["qf", "vista_kind", "terminal", "packer"]
colorscheme dracula

"
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" 次に文字が出てくるまでジャンプ
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

augroup RustCommands
    autocmd!
    autocmd FileType rust nnoremap <silent><leader>oc <cmd>RustOpenCargo<CR>
    autocmd FileType rust nnoremap <silent><leader>k <cmd>RustMoveItemUp<CR>
    autocmd FileType rust nnoremap <silent><leader>j <cmd>RustMoveItemDown<CR>
    autocmd FileType rust nnoremap <silent><leader>vg <cmd>RustViewCrateGraph<CR>
    autocmd FileType rust nnoremap <silent><leader>run <cmd>RustRunnables<CR>
    autocmd FileType rust nnoremap <silent><leader>mac <cmd>RustExpandMacro<CR>
    autocmd FileType rust nnoremap <silent><leader>up <cmd>RustParentModule<CR>
    autocmd FileType rust nnoremap <silent><leader>join <cmd>RustJoinLines<CR>
augroup END

augroup TomlCommands
    autocmd!
    autocmd FileType toml lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }
augroup END

let g:strip_whitespace_on_save = 1

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
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- The following example advertise capabilities to `clangd`.
--require'lspconfig'.clangd.setup {
--  capabilities = capabilities,
--}

--local on_attach = function(client, bufnr)
--    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--    local opts = { noremap = true, silent = true }
--
--    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--    buf_set_keymap("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
--end
--require('nvim-lsp-installer').on_server_ready(function(server)
--    local opts = {}
--    opts.on_attach = on_attach
--
--    server:setup(opts)
--end)
require("telescope").load_extension("frecency")
require("nvim-treesitter.configs").setup {
    yati = { enable = true },
    context_commentstring = { enable = true },
    matchup = {
        enable = true,
    }
}
require('lualine').setup {}
require('todo-comments').setup {}
require('nvim-gps').setup {}
require('fidget').setup {}
require('hop').setup {}
require('nvim-autopairs').setup {}
require('colorizer').setup {}
require('neogit').setup {}
require('gitsigns').setup {}
require('neo-tree').setup {
    close_if_last_window = false,
    enable_git_status = true,
    enable_diagnostics = true,
    indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "|",
        last_indent_marker = "└",
		highlight = "NeoTreeIndentMarker",
    },
    event_handlers = {
        {
            event = "file_opened",
            handler = function(file_path)
                require('neo-tree').close_all()
            end,
        },
        {
            event = "file_added",
            handler = function(file_path)
                require('neo-tree').open_file({}, file_path)
            end,
        },
    },
    filesystem = {
        filtered_items = {
            hide_gitignored = true,
            hide_by_name = {
                ".DS_Store",
                "thumbs.db",
            }
        }
    },
    window = {
        position = "left",
        width = 30,
        mappings = {
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["S"] = "open_split",
			["s"] = "open_vsplit",
			["C"] = "close_node",
			["<bs>"] = "navigate_up",
			["."] = "set_root",
			["H"] = "toggle_hidden",
			["I"] = "toggle_gitignore",
			["R"] = "refresh",
			["/"] = "fuzzy_finder",
			--["/"] = "filter_as_you_type", -- this was the default until v1.28
			--["/"] = "none" -- Assigning a key to "none" will remove the default mapping
			["f"] = "filter_on_submit",
			["<c-x>"] = "clear_filter",
			["a"] = "add",
			["d"] = "delete",
			["r"] = "rename",
			["c"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["m"] = "move", -- takes text input for destination
			["q"] = "close_window",
        }
    },
    git_status = {
		window = {
			position = "float",
			mappings = {
				["<2-LeftMouse>"] = "open",
				["<cr>"] = "open",
				["S"] = "open_split",
				["s"] = "open_vsplit",
				["C"] = "close_node",
				["R"] = "refresh",
				["d"] = "delete",
				["r"] = "rename",
				["c"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["A"] = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
			},
		},
	},
}

local colors = require('tokyonight.colors').setup {}
require('scrollbar').setup {}
require('scrollbar.handlers.search').setup {}

require('indent_blankline').setup {
    show_current_context = false,
    use_treesitter = true,
}

vim.opt.cursorline = true
require('modes').setup {}
vim.cmd('hi ModesCopy guibg=#f5c359 ctermfg=100')
vim.cmd('hi ModesDelete guibg=#c75c6a ctermfg=100')
vim.cmd('hi ModesInsert guibg=#78ccc5 ctermfg=100')
vim.cmd('hi ModesVisual guibg=#9745be ctermfg=100')

require('alpha').setup(require("alpha.themes.startify").config)
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
require('crates').setup {}

vim.api.nvim_set_keymap("n", "hw", "<Cmd>HopWord<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "hw", "<Cmd>HopWord<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gx", "<Cmd>NeoTreeRevealToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "G,", "<Cmd>NeoTreeFloatToggle git_status<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "git", "<Cmd>Neogit<CR>", { noremap = true, silent = true })

EOF
