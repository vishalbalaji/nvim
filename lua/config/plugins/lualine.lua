local M = {
	"nvim-lualine/lualine.nvim",
	enabled = true,
	lazy = false,
	cond = function()
		local exclude_filetypes = { "man" }
		if vim.tbl_contains(exclude_filetypes, vim.bo.filetype) then
			vim.opt.laststatus = 0
			return false
		end
		return true
	end,
}

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

function M.config()
	if vim.g.started_by_firenvim then
		return
	end

	local colors = require("config.plugins.colors").get_colors()
	local ui_icons = require("config.icons").ui

	local lsp_sign_icons = require("config.plugins.lsp").lsp_sign_icons
	local diagnostic_icons = {}
	for k, v in pairs(lsp_sign_icons) do
		diagnostic_icons[k:lower()] = v .. " "
	end

	require("lualine").setup({
		options = {
			theme = "auto",
			section_separators = { left = ui_icons.BoldRoundedDividerRight, right = ui_icons.BoldRoundedDividerLeft },
			component_separators = { left = ui_icons.DividerRight, right = ui_icons.DividerLeft },
			icons_enabled = true,
			globalstatus = true,
			disabled_filetypes = { statusline = { "dashboard" } },
		},
		sections = {
			lualine_a = { { "mode", separator = { right = ui_icons.BoldRoundedDividerRight } } },
			lualine_b = { "branch" },
			lualine_c = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = diagnostic_icons,
				},
				{
					"filetype",
					icon_only = true,
					separator = "",
					padding = {
						left = 1,
						right = 0,
					},
				},
				{ "filename", path = 1, symbols = { modified = ui_icons.Circle, color = { fg = colors.green } } },
			},
			lualine_x = {
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
					color = { fg = colors.blue },
				},
			},
			lualine_y = {
				lsp_module,
			},
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		extensions = { "neo-tree" },
	})
end

return M
