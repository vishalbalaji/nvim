local M = {
	"unblevable/quick-scope",
	enabled = true,
	event = "VeryLazy",
}

M.init = function()
	local c = require("config.plugins.colors")
	local colors = c.get_colors()
	local hl = c.hl

	vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

	hl("QuickScopePrimary", { fg = colors.green, standout = true })
	hl("QuickScopeSecondary", { fg = colors.yellow, standout = true })
end

return M
