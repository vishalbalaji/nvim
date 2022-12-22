local M = {
	"noib3/cokeline.nvim",
	enabled = true,
	requires = "kyazdani42/nvim-web-devicons", -- If you want devicons
	event = "VimEnter",
}

local function is_neotree_open()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "ft") == "neo-tree" then
			return true
		end
	end
	return false
end

M.init = function()
	local map = require("config.keymaps")
	map("n", "<M-S-k>", "<Plug>(cokeline-focus-next)")
	map("n", "<M-S-j>", "<Plug>(cokeline-focus-prev)")
	map("n", "<M-S-l>", "<Plug>(cokeline-switch-next)")
	map("n", "<M-S-h>", "<Plug>(cokeline-switch-prev)")
end

M.config = function()
	local cokeline = require("cokeline")

	local get_hex = require("cokeline/utils").get_hex
	local mappings = require("cokeline/mappings")

	local colors = require("config.plugins.colors").get_colors()
	local lsp_sign_icons = require("config.plugins.lsp").lsp_sign_icons

	local fg_errors = colors.red
	local fg_warnings = colors.yellow
	local fg_indicator = colors.green
	local fg_picking_focus = colors.yellow
	local fg_picking_closed = colors.red
	local fg_is_modified = colors.green
	local fg_sidebar = colors.yellow
	local fg_inactive = colors.comment_fg
	local bg_sidebar = colors.bg_alt

	local fg_sidebar_sep = get_hex("NeoTreeWinSeparator", "fg")
	local bg_sep = get_hex("WinSeparator", "fg")
	local bg_select = get_hex("NormalAlt", "bg")

	if fg_sidebar_sep == "NONE" then
		fg_sidebar_sep = get_hex("FloatBorder", "fg")
	end

	local components = {
		sidebar_separator = {
			text = function(buffer)
				if buffer.is_first and is_neotree_open() and fg_sidebar_sep ~= "NONE" then
					return " "
				else
					return ""
				end
			end,
			bg = bg_sidebar,
			fg = fg_sidebar_sep,
		},

		indicator = {
			text = function(buffer)
				if buffer.is_focused then
					return "▎"
				else
					if buffer.is_first then
						return " "
					else
						return "▎"
					end
				end
			end,
			fg = function(buffer)
				return buffer.is_focused and fg_indicator or nil
			end,
		},

		space = {
			text = " ",
			truncation = { priority = 1 },
		},

		two_spaces = {
			text = "  ",
			truncation = { priority = 1 },
		},

		separator = {
			text = function(buffer)
				return buffer.is_first and "▎" or ""
			end,
			truncation = { priority = 1 },
		},

		devicon = {
			text = function(buffer)
				return (mappings.is_picking_focus() or mappings.is_picking_close()) and buffer.pick_letter .. " "
					or buffer.devicon.icon
			end,
			fg = function(buffer)
				return (mappings.is_picking_focus() and fg_picking_focus)
					or (mappings.is_picking_close() and fg_picking_closed)
					or (not buffer.is_focused and fg_inactive)
					or buffer.devicon.color
			end,
			style = function(_)
				return (mappings.is_picking_focus() or mappings.is_picking_close()) and "italic,bold" or nil
			end,
			truncation = { priority = 1 },
		},

		unique_prefix = {
			text = function(buffer)
				return buffer.unique_prefix
			end,
			fg = fg_inactive,
			style = "italic",
			truncation = {
				priority = 3,
				direction = "left",
			},
		},

		index = {
			text = function(buffer)
				return buffer.index .. ": "
			end,
			truncation = { priority = 1 },
		},

		filename = {
			text = function(buffer)
				return buffer.filename
			end,
			fg = function(buffer)
				return (buffer.diagnostics.errors ~= 0 and fg_errors)
					or (buffer.diagnostics.warnings ~= 0 and fg_warnings)
					or (buffer.is_readonly and fg_inactive)
					or nil
			end,
			style = function(buffer)
				return ((buffer.is_focused and buffer.diagnostics.errors ~= 0) and "bold,underline,italic")
					or (buffer.is_focused and "bold,italic")
					or (buffer.diagnostics.errors ~= 0 and "underline")
					or nil
			end,
			truncation = {
				priority = 2,
				direction = "left",
			},
		},

		read_only = {
			text = function(buffer)
				if buffer.is_readonly then
					return " 🔒"
				end
				return ""
			end,
		},

		diagnostics = {
			text = function(buffer)
				return (
					buffer.diagnostics.errors ~= 0
					and string.format(" %s %s", lsp_sign_icons.error, buffer.diagnostics.errors)
				)
					or (buffer.diagnostics.warnings ~= 0 and string.format(
						" %s %s",
						lsp_sign_icons.warn,
						buffer.diagnostics.warnings
					))
					or ""
			end,
			fg = function(buffer)
				return (buffer.diagnostics.errors ~= 0 and fg_errors)
					or (buffer.diagnostics.warnings ~= 0 and fg_warnings)
					or nil
			end,
			truncation = { priority = 1 },
		},

		close_or_unsaved = {
			text = function(buffer)
				return buffer.is_modified and "●" or ""
			end,
			fg = function(buffer)
				return buffer.is_modified and fg_is_modified or nil
			end,
			delete_buffer_on_left_click = true,
			truncation = { priority = 1 },
		},

		cap = {
			text = function(buffer)
				return buffer.is_last and "▎" or ""
			end,
			truncation = { priority = 1 },
			fg = bg_sep,
			bg = get_hex("Normal", "bg"),
		},
	}

	cokeline.setup({
		buffers = {
			-- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
			-- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
			new_buffers_position = "next",
		},

		rendering = {
			max_buffer_width = 30,
		},

		default_hl = {
			fg = function(buffer)
				return buffer.is_focused and get_hex("Normal", "fg") or fg_inactive
			end,
			bg = function(buffer)
				return buffer.is_focused and bg_select or get_hex("TabLineFill", "bg")
			end,
			style = function(buffer)
				return buffer.is_focused and "italic" or nil
			end,
		},

		sidebar = {
			filetype = "neo-tree",
			components = {
				{
					text = "",
					fg = fg_sidebar,
					bg = bg_sidebar,
					style = "bold",
				},
			},
		},

		components = {
			components.sidebar_separator,
			components.indicator,
			components.space,
			components.devicon,
			components.unique_prefix,
			components.index,
			components.filename,
			components.read_only,
			components.diagnostics,
			components.two_spaces,
			components.close_or_unsaved,
			components.space,
			components.space,
			components.cap,
		},
	})
end

return M
