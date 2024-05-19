return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  init = function() end,
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.load_extension("ui-select")
    telescope.setup({
      pickers = {
        live_grep = {
          mappings = {
            i = {
              ["<C-o>"] = actions.send_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.send_to_loclist + actions.open_loclist,
            },
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })
  end,
}
