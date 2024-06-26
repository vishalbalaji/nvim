return { -- You can easily change to a different colorscheme.
	-- Change the name of the colorscheme plugin below, and then
	-- change the command in the config to whatever the name of that colorscheme is.
	--
	-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
	"Everblush/nvim",
	name = "everblush",
	opts = {
		override = {
			NormalAlt = { bg = "contrast" },
			NonText = { fg = "comment" },
			WinSeparator = { link = "NonText" },
			FoldColumn = { link = "NonText" },
			CursorLine = { bg = "color0" },
			LineNr = { link = "NonText" },
			CursorLineNr = { link = "SpecialComment" },

			TSRainbowRed = { fg = "color1" },
			TSRainbowGreen = { fg = "color2" },
			TSRainbowYellow = { fg = "color3" },
			TSRainbowBlue = { fg = "color4" },
			TSRainbowViolet = { fg = "color5" },
			TSRainbowCyan = { fg = "color6" },
			TSRainbowOrange = { fg = "color7" },
		},
	},
	init = function()
		-- Load the colorscheme here.
		-- Like many other themes, this one has different styles, and you could load
		-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
		vim.cmd.colorscheme("everblush")
	end,
}
