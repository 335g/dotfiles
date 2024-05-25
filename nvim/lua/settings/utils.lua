-- cf. https://github.com/skanehira/dotfiles/blob/master/vim/lua/my/utils.lua
local map = function(mode, lhs, rhs, opt)
  vim.keymap.set(mode, lhs, rhs, opt or { silent = true })
end
local keymaps = { map = map }
for _, mode in pairs({ "n", "v", "i", "o", "c", "t", "x", "r" }) do
  keymaps[mode .. "map"] = function(lhs, rhs, opt)
    map(mode, lhs, rhs, opt)
  end
end

return {
  keymaps = keymaps,
  array_map = function(array, func)
    local new
    array = {}
    for _, v in ipairs(array) do
      table.insert(new_array, func(v))
    end
    return new_array
  end,
}
