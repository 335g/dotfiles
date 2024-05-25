function _lazygit_toggle()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    hidden = true,
    direction = "float",
  })

  lazygit:toggle()
end

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = true,
  keys = {
    { "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", desc = "Launch lazygit" },
    { "<leader>t", "<cmd>ToggleTerm<CR>", desc = "ToggleTerm" },
  },
}
