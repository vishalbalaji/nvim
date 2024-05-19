local M = {
	"nvim-tree/nvim-web-devicons",
	enabled = true,
	lazy = false,
	priority = 1000,
}

M.config = function()
	local devicons = require("nvim-web-devicons")
	devicons.setup({
		override = {
			["astro"] = {
				icon = "",
				color = "#EC682C",
				cterm_color = "197",
				name = "Astro",
			},
		},
		override_by_filename = {
			[".prettierrc"] = {
				icon = "󰫽",
				color = "#F7B93E",
				cterm_color = "65",
				name = "Prettier",
			},
			[".prettierignore"] = {
				icon = "󰫽",
				color = "#F7B93E",
				cterm_color = "65",
				name = "Prettier",
			},
		},
	})

	local default_icon_color = "#6d8086"
	devicons.set_default_icon("", default_icon_color, 65)
	require("config.plugins.colors").safe_hl("DevIconsDefault", { fg = default_icon_color })
end

return M
