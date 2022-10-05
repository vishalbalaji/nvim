local function hide_in_width()
	return vim.fn.winwidth(0) > 80
end

return {
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "｜", right = "｜" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "Outline" },
		always_divide_middle = true,
	},
	globalstatus = true,
	extensions = { "quickfix", "aerial", "nvim-tree", "toggleterm", "man" },

	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},

	sections = {
		lualine_b = {
			{
				"filename",
				symbols = {
					modified = "●",
					readonly = "",
				},
			},
			{
				"diagnostics",
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = " ",
				},
			},
		},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {
			{
				"diff",
				symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
				cond = hide_in_width,
			},
			"branch",
			"filetype",
		},
		lualine_z = { "progress" },
	},
}
