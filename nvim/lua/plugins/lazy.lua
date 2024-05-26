local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- colorscheme
  require("plugins/colorscheme/iceberg"),
  require("plugins/colorscheme/nightfox"),
  require("plugins/colorscheme/dracula"),
  require("plugins/colorscheme/ayu"),
  require("plugins/colorscheme/tokyonight"),

  -- finder
  require("plugins/finder/telescope"),
  require("plugins/finder/neo-tree"),

  -- statusline
  require("plugins/statusline/lualine"),
  require("plugins/statusline/bufferline"),

  -- snippet
  require("plugins/snippet/luasnip"),

  -- formatter
  require("plugins/formatter/conform"),

  -- completion
  require("plugins/completion/nvim-cmp"),
  require("plugins/completion/nvim-autopairs"),
  require("plugins/completion/comment"),
  require("plugins/completion/copilot"),

  -- lsp
  require("plugins/lsp/lspconfig"),
  require("plugins/lsp/lspsaga"),
  require("plugins/lsp/mason"),

  -- utility
  require("plugins/utility/toggleterm"),

  -- others
  require("plugins/others/tiny-devicons-auto-colors"),
  require("plugins/others/nvim-treesitter"),
  require("plugins/others/alpha-nvim"),
  require("plugins/others/noice"),
}
require("lazy").setup(plugins)
