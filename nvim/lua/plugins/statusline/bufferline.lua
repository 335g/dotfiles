return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      buffer_close_icon = "x",
      mode = "tabs",
      hover = {
        enabled = true,
      },
    },
  },
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<CR>", { silent = true, noremap = true, desc = "Buffer Next" } },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { silent = true, noremap = true, desc = "Buffer Prev" } },
  },
}
