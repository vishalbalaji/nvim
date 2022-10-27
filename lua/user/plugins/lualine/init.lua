local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

-- Now don't forget to initialize lualine
local config = require("user.plugins.lualine.configs.default")

-- config.options.theme.normal.c.bg = "NONE"
config.extensions = { "quickfix", "aerial", "nvim-tree", "toggleterm", "man" }

lualine.setup(config)
