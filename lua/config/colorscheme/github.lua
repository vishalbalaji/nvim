return {
	"projekt0n/github-nvim-theme",
	name = "github-theme",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("github-theme").setup({
			groups = {
				all = {
					NormalAlt = { bg = "bg0" },
					FloatBorder = { link = "NormalAlt" },

					RainbowRed = { fg = "palette.red" },
					RainbowGreen = { fg = "palette.green" },
					RainbowYellow = { fg = "palette.yellow" },
					RainbowBlue = { fg = "palette.blue" },
					RainbowViolet = { fg = "palette.magenta" },
					RainbowCyan = { fg = "palette.cyan" },
					RainbowOrange = { fg = "palette.orange" },

					CursorLine = { bg = "bg2" },
					Search = { link = "MiniCursorWord" },
					Visual = { link = "CursorLine" },
					MatchParen = { bg = "bg3", fg = "NONE" },
					Comment = { fg = "bg3" },
					SpecialComment = { link = "RainbowBlue" },
					NonText = { link = "Comment" },
					FoldColumn = { link = "NonText" },
					ColorColumn = { link = "CursorLine" },
					LineNr = { link = "NonText" },
					CursorLineNr = { link = "SpecialComment" },
					WinSeparator = { link = "NonText" },
					SpellBad = { link = "DiagnosticUnderlineError" },
				},
			},
		})

		local theme = "github_dark_default"
		vim.cmd.colorscheme(theme)
		local lualine_theme = require("lualine.themes." .. theme)
		for _, mode in pairs(lualine_theme) do
			mode.b = { fg = mode.a.bg }
		end
		Config.lualine.create_highlight_groups(lualine_theme)

		Config.util.mod_hl("Comment", { italic = true })
	end,
}
