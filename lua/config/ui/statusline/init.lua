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
			hl = { link = "NonText" },

			nc = {
				hl = { link = "RainbowRed" },
				fillchar = ".",
			},

			groups = {
				left = {
					{
						m.mode,
						hl = m.get_mode_hl("b"),
					},
					m.git,
				},

				middle = {
					{
						m.filename,
						format = function(val)
							local modified = vim.api.nvim_eval_statusline("%m", {}).str
							local items = {}
							if modified ~= "" then
								table.insert(items, m.hl(Config.icons.ui.Circle, "RainbowGreen"))
							end
							table.insert(items, m.hl(val, "Normal"))
							return table.concat(items, " ")
						end,
					},
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
		vim.opt.showcmdloc = "statusline"
		require("config.ui.statusline.core").setup(opts)
	end,
}
