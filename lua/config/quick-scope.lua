vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

return {
	"unblevable/quick-scope",
	keys = vim.g.qs_highlight_on_keys,
	config = function()
		local green = Config.util.get_hl("RainbowGreen").fg
		local yellow = Config.util.get_hl("RainbowYellow").fg
		Config.util.hl("QuickScopePrimary", { fg = green, standout = true })
		Config.util.hl("QuickScopeSecondary", { fg = yellow, standout = true })
	end,
}
