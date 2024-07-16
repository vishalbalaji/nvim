return {
	name = "statusline",
	dir = "config.ui.statusline",
	dependencies = {
		require("config.colorscheme"),
		require("config.devicons"),
	},
	opts = function()
		local m = require("config.ui.statusline.modules")

		local ft_icon = m.create.ft_icon()

		---@type StatusLineConfig
		return {
			fillchar = "━",
			hl = { link = "NonText" },

			nc = {
				hl = { link = "TSRainbowRed" },
				fillchar = ".",
			},

			groups = {
				left = {
					{ m.mode, hl = m.util.get_mode_hl("b") },
					m.git,
				},

				middle = {
					{
						m.filename,
						format = function(val, opts)
							local modified = vim.api.nvim_eval_statusline("%m", {}).str
							local items = {}

							if modified ~= "" then
								table.insert(items, m.util.hl(Config.icons.ui.Circle, "TSRainbowGreen"))
							end

							local icon = ft_icon()
							if icon ~= "" then
								table.insert(items, icon)
							end

							table.insert(items, m.util.hl(val, opts.hl))
							return table.concat(items, " ")
						end,
					},
				},

				right = {
					function()
						return vim.t.maximized and "" or ""
					end,
					ft_icon,
					m.ft,
					m.create.diagnostics(),
					{ require("lazy.status").updates, hl = "Special" },
					m.create.showcmd(),
					m.macro_recording,
					{
						m.lineinfo,
						hl = "NonText",
					},
				},
			},
		}
	end,
	config = function(_, opts)
		require("config.ui.statusline.core").setup(opts)
	end,
}
