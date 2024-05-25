local u = require("settings/utils")
local nmap = u.keymaps.nmap
local omap = u.keymaps.omap
local imap = u.keymaps.imap
local xmap = u.keymaps.xmap
local cmap = u.keymaps.cmap
local tmap = u.keymaps.tmap
local map = u.keymaps.map

-- 基本的に表示行移動に
nmap("j", "gj")
nmap("k", "gk")
nmap("gj", "j")
nmap("gk", "k")

-- ハイライト解除
nmap("<ESC><ESC>", "<CMD>nohlsearch<CR>", { desc = "Unhighlight" })
