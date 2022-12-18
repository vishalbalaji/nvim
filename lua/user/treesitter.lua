local config = {}

-- Base-Level Settings
config.ensure_installed = { "c", "lua", "rust", "help", "javascript", "typescript", "vim" }
config.sync_install = false
config.auto_install = true

-- TS Plugins
config.indent = {
	enable = true,
	disable = { "yaml", "python" },
}

config.highlight = {
	enable = true,
	additional_vim_regex_highlighting = false,
}

config.incremental_selection = {
	enable = true,
	keymaps = {
		init_selection = "<c-space>",
		node_incremental = "<c-space>",
		scope_incremental = "<c-s>",
		node_decremental = "<c-backspace>",
	},
}

local colors = require("colors")
config.rainbow = {
	enable = true,
	extended_mode = true,
	colors = {
		colors.red,
		colors.yellow,
		colors.green,
		colors.cyan,
		colors.blue,
		colors.magenta,
	},
	termcolors = {
		"Red",
		"Yellow",
		"Green",
		"Cyan",
		"Blue",
		"Magenta",
	},
}

require("nvim-treesitter.configs").setup(config)
