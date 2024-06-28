vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

return {
	"unblevable/quick-scope",
	keys = vim.g.qs_highlight_on_keys,
	config = function()
		local green = Config.get_hl("TSRainbowGreen").fg
		local yellow = Config.get_hl("TSRainbowYellow").fg
		Config.hl("QuickScopePrimary", { fg = green, standout = true })
		Config.hl("QuickScopeSecondary", { fg = yellow, standout = true })
	end,
}
