return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",
    "hrsh7th/cmp-nvim-lsp-signature-help",
		"onsails/lspkind.nvim",
  },
  config = function()
		local cmp = require("cmp")
		cmp.setup {
			window = {
				completion = cmp.config.window.bordered({
					completeopt = "menu,menuone,preview",
					border = "rounded",
					winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					border = "rounded",
				})
			},
			formatting = {
				format = require("lspkind").cmp_format({
					preset = "codicons",
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
			mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "dictionary", keyword_length = 2 },
      },
		}

		cmp.event:on("confirm_done", function()
			require("nvim-autopairs.completion.cmp").on_confirm_done()
		end)
  end,
}
