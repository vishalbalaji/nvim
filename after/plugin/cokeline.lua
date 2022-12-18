if vim.g.started_by_firenvim then
  return
end

local cokeline = require("cokeline")

local get_hex = require("cokeline/utils").get_hex
local mappings = require("cokeline/mappings")

local colors = require("colors")

local errors_fg = colors.red
local warnings_fg = colors.yellow
local fg_inactive = get_hex("Comment", "fg")
local bg_sep = get_hex("WinSeparator", "fg")
local bg_select = get_hex("NormalAlt", "bg")

local bg_sidebar = get_hex("NeoTreeWinSeparator", "bg")
local fg_sidebar_sep = get_hex("NeoTreeWinSeparator", "fg")

if fg_sidebar_sep == "NONE" then
	fg_sidebar_sep = get_hex("FloatBorder", "fg")
end

local components = {
	sidebar_separator = {
		text = function(buffer)
      if buffer.is_first and vim.g.neotree_visible and fg_sidebar_sep ~= "NONE" then
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
			return buffer.is_focused and colors.green or nil
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
			return (mappings.is_picking_focus() and colors.yellow)
				or (mappings.is_picking_close() and colors.red)
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
			return (buffer.diagnostics.errors ~= 0 and errors_fg)
				or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
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
			return (buffer.diagnostics.errors ~= 0 and "  " .. buffer.diagnostics.errors)
				or (buffer.diagnostics.warnings ~= 0 and "  " .. buffer.diagnostics.warnings)
				or ""
		end,
		fg = function(buffer)
			return (buffer.diagnostics.errors ~= 0 and errors_fg)
				or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
				or nil
		end,
		truncation = { priority = 1 },
	},

	close_or_unsaved = {
		text = function(buffer)
			return buffer.is_modified and "●" or ""
		end,
		fg = function(buffer)
			return buffer.is_modified and colors.green or nil
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
				fg = colors.yellow,
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
