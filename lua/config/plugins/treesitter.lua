local M = {
	"nvim-treesitter/nvim-treesitter",
	enabled = true,
	build = ":TSUpdate",
	event = "BufReadPost",
	dependencies = {
		{ "p00f/nvim-ts-rainbow", event = "VeryLazy" },
	},
}

M.config = function()
	local config = {}
	local colors = require("config.plugins.colors").get_colors()

	-- Base-Level Settings
	config.ensure_installed = { "c", "lua", "rust", "help", "javascript", "typescript", "vim" }
	config.sync_install = false
	config.auto_install = true

	-- TS Plugins
	config.highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	}

	config.indent = {
		enable = true,
		disable = { "yaml", "python" },
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
			colors.red,
			colors.yellow,
			colors.green,
			colors.cyan,
			colors.blue,
			colors.magenta or colors.purple,
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
end

return M
