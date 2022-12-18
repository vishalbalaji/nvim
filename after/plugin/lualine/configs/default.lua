local function hide_in_width()
	return vim.fn.winwidth(0) > 80
end

local lsp_module = {
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
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
	icon = "",
	color = { gui = "bold" },
}

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
				symbols = { added = " ", modified = "柳", removed = " " },
				cond = hide_in_width,
			},
			"branch",
			"filetype",
      lsp_module,
		},
		lualine_z = { "progress" },
	},
}

