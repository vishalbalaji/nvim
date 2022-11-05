local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

-- Now don't forget to initialize lualine
local config = require("user.plugins.lualine.configs.default")

-- config.options.theme.normal.c.bg = "NONE"-

-- Extensions
local custom_names = {
	sections = {
		lualine_a = {
			function()
				local title = string.gsub(" " .. vim.bo.filetype, "%W%l", string.upper):sub(2)
				return title
			end,
		},
	},
	filetypes = { "Trouble", "aerial" },
}
config.extensions = { "quickfix", "nvim-tree", "man", custom_names }

lualine.setup(config)
