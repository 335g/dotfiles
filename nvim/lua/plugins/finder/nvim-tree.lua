return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<Leader>n", "<cmd>NvimTreeToggle<CR>", { silent = true, desc = "NvimTreeToggle" } },
  },
  opts = {
    hijack_cursor = false,
    sort_by = "case_sensitive",
    view = {
      adaptive_size = true,
      side = "right",
      width = 35,
    },
    actions = {
      use_system_clipboard = true,
    },
    renderer = {
      indent_markers = {
        enable = true,
      },
      group_empty = true,
      highlight_git = true,
      highlight_diagnostics = true,
      highlight_bookmarks = "all",
      highlight_clipboard = "all",
      icons = {
        webdev_colors = true,
        git_placement = "after",
        modified_placement = "after",
        glyphs = {
          git = {
            unstaged = "U",
            staged = "A",
            unmerged = "M",
            renamed = "R",
            untracked = "?",
            deleted = "D",
            ignored = "!",
          },
        },
      },
    },
    filters = {
      dotfiles = false,
      custom = { "^.git", "node_modules" },
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end
      -- default mappigns
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
      vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
    end,
  },
}
