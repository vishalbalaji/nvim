local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local config = {}

-- Base-Level Settings
config.ensure_installed = "all" -- one of "all", "maintained" (parsers with maintainers), or a list of languages
config.ignore_install = { "phpdoc" }
config.sync_install = false -- install languages synchronously (only applied to `ensure_installed`)

-- TS Plugins
-- -- Autopairs
config.autopairs = {
	enable = true,
}

-- -- Highlight
config.highlight = {
	enable = true, -- false will disable the whole extension
	disable = { "" }, -- list of language that will be disabled
	additional_vim_regex_highlighting = true,
}

-- -- Indent
config.indent = {
	enable = true,
	disable = { "yaml", "python" },
}

-- -- Context Commentstring
config.context_commentstring = {
	enable = true,
	enable_autocmd = false,
	config = {},
}

-- -- AutoTag
config.autotag = {
	enable = true,
}

-- -- Rainbow
local colors = require("user.colorscheme")
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

config.playground = {
	enable = true,
	keybindings = {
		toggle_query_editor = "e",
	},
}

configs.query_linter = {
	enable = true,
	use_virtual_text = true,
	lint_events = { "BufWrite", "CursorHold" },
}

configs.setup(config)

require("pretty-fold").setup({})
