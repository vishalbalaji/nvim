local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local colors = require("user.colorscheme")

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = true,
	update_in_insert = false,
	always_visible = false,
	diagnostics_color = {
		-- Same values as the general color option can be used here.
		error = "DiagnosticError", -- Changes diagnostics' error color.
		warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
		info = "DiagnosticInfo", -- Changes diagnostics' info color.
		hint = "DiagnosticHint", -- Changes diagnostics' hint color.
	},
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	diff_color = {
		-- Same color values as the general color option can be used here.
		added = "DiffAdd", -- Changes the diff's added color
		modified = "DiffChange", -- Changes the diff's modified color
		removed = "DiffDelete", -- Changes the diff's removed color you
	},
	cond = hide_in_width,
}

local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
	colored = true,
}

local filetype = {
	"filetype",
	icons_enabled = true,
	icon = nil,
}
local branch = {
	"branch",
	icons_enabled = true,
	colored = true,
	icon = { "", color = { fg = colors.orange } },
}

local location = {
	"location",
	padding = 1,
}

-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local line_ratio = current_line / total_lines
	-- local chars = { "▁▁", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	-- local index = math.ceil(line_ratio * #chars)
	-- return chars[index]
	return string.format("%d", line_ratio * 100) .. "%%"
end

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local encoding = {
	"encoding",
	color = { fg = colors.green },
}

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "｜" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "Outline" },
		always_divide_middle = true,
	},
	globalstatus = true,
	sections = {
		lualine_a = {},
		lualine_b = { mode },
		lualine_c = { diagnostics },
		lualine_x = { filetype, branch, diff, encoding, spaces },
		lualine_y = { location },
		lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "quickfix", "aerial", "nvim-tree", "toggleterm", "man" },
})

local lualine_bg = vim.api.nvim_get_hl_by_name("lualine_c_normal", true).background
local add_fg = vim.api.nvim_get_hl_by_name("DiffAdd", true).foreground
local change_fg = vim.api.nvim_get_hl_by_name("DiffChange", true).foreground
local delete_fg = vim.api.nvim_get_hl_by_name("DiffDelete", true).foreground
vim.api.nvim_set_hl(0, "lualine_x_diff_added", { bg = lualine_bg, fg = add_fg })
vim.api.nvim_set_hl(0, "lualine_x_diff_modified", { bg = lualine_bg, fg = change_fg })
vim.api.nvim_set_hl(0, "lualine_x_diff_removed", { bg = lualine_bg, fg = delete_fg })
