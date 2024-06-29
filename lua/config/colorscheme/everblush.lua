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
			CursorLine = { bg = "color0" },

			RainbowRed = { fg = "color1" },
			RainbowGreen = { fg = "color2" },
			RainbowYellow = { fg = "color3" },
			RainbowBlue = { fg = "color4" },
			RainbowViolet = { fg = "color5" },
			RainbowCyan = { fg = "color6" },
			RainbowOrange = { fg = "color7" },
		},
	},
	init = function()
		-- Load the colorscheme here.
		vim.cmd.colorscheme("everblush")

		local lualine_theme = require("lualine.themes.everblush")
		lualine_theme.normal.b = { fg = lualine_theme.normal.a.bg }

		for _, mode in pairs(lualine_theme) do
			mode.b.gui = "bold"
		end

		Config.lualine.create_highlight_groups(lualine_theme)
	end,
}
