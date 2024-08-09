vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

function _G.o(...)
	print(vim.inspect(...))
end

local Config = {}

Config.util = require("config.global.util")

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		Config.util.hl_fallback("RainbowRed", { fg = "red" })
		Config.util.hl_fallback("RainbowGreen", { fg = "green" })
		Config.util.hl_fallback("RainbowYellow", { fg = "yellow" })
		Config.util.hl_fallback("RainbowBlue", { fg = "blue" })
		Config.util.hl_fallback("RainbowViolet", { fg = "violet" })
		Config.util.hl_fallback("RainbowCyan", { fg = "cyan" })
		Config.util.hl_fallback("RainbowOrange", { fg = "orange" })
	end,
})

local icons = require("config.global.icons")
Config.icons = icons

Config.lsp = require("config.global.lsp")
Config.lsp.signs = {
	[-1] = { label = "Other", icon = icons.diagnostics.BoldQuestion },
	[vim.diagnostic.severity.ERROR] = { label = "Error", icon = icons.diagnostics.BoldError },
	[vim.diagnostic.severity.WARN] = { label = "Warn", icon = icons.diagnostics.BoldWarning },
	[vim.diagnostic.severity.HINT] = { label = "Hint", icon = icons.diagnostics.BoldHint },
	[vim.diagnostic.severity.INFO] = { label = "Info", icon = icons.diagnostics.BoldInformation },
}

local lualine = require("lib.lualine")
Config.lualine = {
	create_highlight_groups = lualine.create_highlight_groups,
	get_mode = lualine.get_mode,
	get_mode_suffix = lualine.get_mode_suffix,
}

_G.Config = Config
