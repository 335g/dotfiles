-- command
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

--
vim.g.mapleader = " "

-- vim.opt.termguicolors = true

-- opt
vim.opt.incsearch = true

-- 行番号
vim.opt.number = true -- 行番号

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.showtabline = 1
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- swapファイルを生成しない
vim.opt.swapfile = false

-- マウス操作
vim.opt.mouse = "a"

-- モード非表示
vim.opt.showmode = false

-- クリップボードの共有
vim.opt.clipboard = "unnamedplus"

-- Undo
vim.opt.undofile = true

-- 大文字/小文字
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ウィンドウ分割
vim.opt.splitright = true
vim.opt.splitbelow = true

-- 空白文字の可視化
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- カーソル行ハイライト
vim.opt.cursorline = true

-- 検索結果ハイライト
vim.opt.hlsearch = true

vim.opt.guifont = "Hack Nerd Font" -- フォント
