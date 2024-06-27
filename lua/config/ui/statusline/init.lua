return {
	name = "statusline",
	dir = "",
	dependencies = {
		require("config.colorscheme"),
	},
	opts = function()
		local m = require("config.ui.statusline.modules")

		---@type StatuslineConfig
		return {
			fillchar = "━",

			groups = {
				left = {
					{ m.mode, hl = "SpecialComment" },
					m.git,
				},

				middle = {
					m.filename,
				},

				right = {
					m.diagnostics,
					m.showcmd,
					m.macro_recording,
					m.lineinfo,
				},
			},
		}
	end,
	config = function(_, opts)
		require("config.ui.statusline.core").setup(opts)
	end,
}
