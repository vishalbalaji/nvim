local lsp_icons = Config.icons.lsp

local M = {
	"nvim-tree/nvim-web-devicons",
	enabled = true,
	lazy = false,
	priority = 999,
}

local function prettier_config_icons(default_icon_color, default_icon_cterm)
	local icons = {}
	local icon = { icon = lsp_icons.prettier, color = "#3264b7", cterm_color = 25, name = "PrettierConfig" }

	for _, value in ipairs(Config.lsp.utils.prettier_config_names) do
		icons[value] = icon
	end
	icons[".prettierignore"] = vim.tbl_extend(
		"force",
		icon,
		{ color = default_icon_color, cterm_color = default_icon_cterm, name = "PrettierIgnore" }
	)

	return icons
end

local function eslint_config_icons(default_icon_color, default_icon_cterm)
	local icons = {}

	local icon = { icon = lsp_icons.eslint, color = "#3b279b", cterm_color = 54, name = "Eslintrc" }

	for _, value in ipairs(Config.lsp.utils.eslint_config_names) do
		icons[value] = icon
	end
	icons[".eslintignore"] = vim.tbl_extend(
		"force",
		icon,
		{ color = default_icon_color, cterm_color = default_icon_cterm, name = "EslintIgnore" }
	)

	return icons
end

local function tailwind_config_icons()
	local icons = {}

	local icon = { icon = lsp_icons.tailwindcss, color = "#158197", cterm_color = 31, name = "TailwindConfig" }
	for _, value in ipairs(Config.lsp.utils.tailwind_config_names) do
		icons[value] = icon
	end

	return icons
end

M.config = function()
	local devicons = require("nvim-web-devicons")
	local default_icon_color = "#6d8086"
	local default_icon_cterm = 231

	local override_by_filename = {}

	override_by_filename =
			vim.tbl_extend("force", override_by_filename, prettier_config_icons(default_icon_color, default_icon_cterm))

	override_by_filename =
			vim.tbl_extend("force", override_by_filename, eslint_config_icons(default_icon_color, default_icon_cterm))

	override_by_filename = vim.tbl_extend("force", override_by_filename, tailwind_config_icons())

	devicons.setup({
		override = {
			["astro"] = {
				icon = lsp_icons.astro,
				color = "#EC682C",
				cterm_color = "202",
				name = "Astro",
			},
		},

		override_by_filename = override_by_filename,
	})

	devicons.set_default_icon(lsp_icons._default, default_icon_color, default_icon_cterm)
	Config.hl("DevIconsDefault", { fg = default_icon_color })
end

return M
