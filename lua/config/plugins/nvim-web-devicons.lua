local M = {
	"nvim-tree/nvim-web-devicons",
	enabled = true,
	lazy = false,
	priority = 1000,
}

local function prettier_config_icons(default_icon_color, default_icon_cterm)
	local icons = {}
	local icon = { icon = "", color = "#3264b7", cterm_color = 25, name = "PrettierConfig" }
	local filenames = {
		".prettierrc",

		".prettierrc.json",
		".prettierrc.json5",

		".prettierrc.yml",
		".prettierrc.yaml",

		".prettierrc.ts",
		".prettierrc.js",
		".prettierrc.cjs",
		".prettierrc.mjs",

		"prettier.config.ts",
		"prettier.config.js",
		"prettier.config.cjs",
		"prettier.config.mjs",

		".prettierrc.toml",
	}

	for _, value in ipairs(filenames) do
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

	local icon = { icon = "", color = "#3b279b", cterm_color = 54, name = "Eslintrc" }
	local filenames = {
		"eslint.config.ts",
		"eslint.config.js",
		"eslint.config.mjs",
		"eslint.config.cjs",

		".eslintrc.ts",
		".eslintrc.js",
		".eslintrc.mjs",
		".eslintrc.cjs",

		".eslintrc.yaml",
		".eslintrc.yml",

		".eslintrc.json",
		".eslintrc.json5",
	}

	for _, value in ipairs(filenames) do
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

	local icon = { icon = "󱏿", color = "#158197", cterm_color = 31, name = "TailwindConfig" }
	local filenames = {
		"tailwind.config.ts",
		"tailwind.config.js",
		"tailwind.config.cjs",
		"tailwind.config.mjs",
	}
	for _, value in ipairs(filenames) do
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
				icon = "",
				color = "#EC682C",
				cterm_color = "202",
				name = "Astro",
			},
		},

		override_by_filename = override_by_filename,
	})

	devicons.set_default_icon("", default_icon_color, default_icon_cterm)
	require("config.plugins.colors").safe_hl("DevIconsDefault", { fg = default_icon_color })
end

return M
