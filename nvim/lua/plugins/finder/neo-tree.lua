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
    -- { "<Leader>nt", "<cmd>Neotree reveal toggle position=left<CR>", desc = "Neotree toggle" },
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
          vim.api.nvim_exec("Neotree source=filesystem position=left", true)
        end,
        ["g"] = function()
          vim.api.nvim_exec("Neotree source=git_status position=left", true)
        end,
      },
    },
  },
}
