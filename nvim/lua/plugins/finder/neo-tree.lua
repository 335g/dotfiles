return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim",
  },
  keys = {
    { "<leader>nt", "<cmd>Neotree reveal toggle position=float<CR>", desc = "Neotree toggle" },
  },
  opts = {
    window = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
      mappings = {
        ["e"] = function()
          vim.api.nvim_exec("Neotree source=filesystem position=float", true)
        end,
        ["g"] = function()
          vim.api.nvim_exec("Neotree source=git_status position=float", true)
        end,
      },
    },
  },
}
