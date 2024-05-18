return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"cocopon/iceberg.vim",
		"cocopon/pgmnt.vim"
	},
	config = function()
		local colors = vim.fn['iceberg#palette#dark#create']()
		local conditions = {
		  buffer_not_empty = function()
		    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
		  end,
		  hide_in_width = function()
		    return vim.fn.winwidth(0) > 80
		  end,
		  check_git_workspace = function()
		    local filepath = vim.fn.expand('%:p:h')
		    local gitdir = vim.fn.finddir('.git', filepath .. ';')
		    return gitdir and #gitdir > 0 and #gitdir < #filepath
		  end,
		}

		local config = {
			options = {
				component_separators = '',
				section_separators = '',
				theme = {
					normal = {
						c = {
							fg = colors.gui.normal_fg,
							bg = colors.gui.normal_bg,
						},
					},
					inactive = {
						c = {
							fg = colors.fg,
							bg = colors.bg,
						},
					},
				},
			},
			sections = {
				lualine_a = {},
		    lualine_b = {},
		    lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
		  table.insert(config.sections.lualine_c, component)
		end
		
		-- Inserts a component in lualine_x at right section
		local function ins_right(component)
		  table.insert(config.sections.lualine_x, component)
		end

		ins_left {
			'mode',
      color = function()
				local mode_state = vim.api.nvim_get_mode().mode
        if mode_state == ("i" or "ic" or "ix") then
          return { fg = colors.gui.normal_bg, bg = colors.gui.blue }
        elseif mode_state == ("v" or "vs" or "V" or "Vs") then
          return { fg = colors.gui.normal_bg, bg = colors.gui.green }
        elseif mode_state == "t" then
          return { fg = colors.gui.normal_bg, bg = colors.gui.orange }
        else
          return { fg = colors.gui.normal_bg, bg = colors.gui.xline_edge_bg }
        end
      end,
      padding = { left = 2, right = 2 },
		}

		ins_left {
			'filetype',
			icon_only = true,
			color = { fg = colors.gui.xline_edge_bg },
		}

		ins_left {
			'filename',
			cond = conditions.buffer_not_empty,
			color = { fg = colors.gui.xline_edge_bg },
		}

		ins_left {
		  'diagnostics',
		  sources = { 'nvim_diagnostic' },
		  symbols = { error = ' ', warn = ' ', info = ' ' },
		  diagnostics_color = {
		    color_error = { fg = colors.gui.red },
		    color_warn = { fg = colors.gui.orange },
		    color_info = { fg = colors.gui.purple },
		  },
		}

		ins_right {
			function()
		    local msg = '-'
		    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
		    local clients = vim.lsp.get_active_clients()
		    if next(clients) == nil then
		      return msg
		    end
		    for _, client in ipairs(clients) do
		      local filetypes = client.config.filetypes
		      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
		        return client.name
		      end
		    end
		    return msg
		  end,
		  icon = ' LSP:',
		  color = { fg = colors.gui.xline_edge_bg },
		}

		ins_right {
		  'branch',
		  icon = '',
		  color = { fg = colors.gui.xline_edge_bg },
		}

		ins_right {
			'encoding',
			color = { fg = colors.gui.xline_edge_bg },
		}

		require('lualine').setup(config)
  end,
}
