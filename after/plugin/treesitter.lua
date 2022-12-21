---@diagnostic disable: undefined-field
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

config.rainbow = {
	enable = true,
	extended_mode = true,
	colors = {
		_G.colors.red,
		_G.colors.yellow,
		_G.colors.green,
		_G.colors.cyan,
		_G.colors.blue,
		_G.colors.magenta or _G.colors.purple,
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
