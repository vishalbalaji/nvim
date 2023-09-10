local M = {
	"tzachar/highlight-undo.nvim",
	enabled = true,
	event = "VeryLazy",
	opts = {
		duration = 300,
		undo = {
			hlgroup = "HighlightUndo",
			mode = "n",
			lhs = "u",
			map = "undo",
			opts = {},
		},
		redo = {
			hlgroup = "HighlightUndo",
			mode = "n",
			lhs = "<C-r>",
			map = "redo",
			opts = {},
		},
		highlight_for_count = true,
	},
}

M.init = function()
	local c = require("config.plugins.colors")
	local hl = c.safe_hl
	local colors = c.get_colors()

	hl("HighlightUndo", { bg = colors.blue, fg = "white" })
end

return M
