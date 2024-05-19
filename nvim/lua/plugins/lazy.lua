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

  -- lsp
  require("plugins/lsp/lspconfig"),
  require("plugins/lsp/lspsaga"),
  require("plugins/lsp/mason"),

  -- others
  require("plugins/others/tiny-devicons-auto-colors"),
}
require("lazy").setup(plugins)
