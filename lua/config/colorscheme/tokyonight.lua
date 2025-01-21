return { -- You can easily change to a different colorscheme.
	-- Change the name of the colorscheme plugin below, and then
	-- change the command in the config to whatever the name of that colorscheme is.
	--
	-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
	"folke/tokyonight.nvim",
	opts = {
		on_highlights = function(hl, c)
			hl.RainbowRed = { fg = c.red }
			hl.RainbowGreen = { fg = c.green }
			hl.RainbowYellow = { fg = c.yellow }
			hl.RainbowBlue = { fg = c.blue }
			hl.RainbowViolet = { fg = c.magenta }
			hl.RainbowCyan = { fg = c.cyan }
			hl.RainbowOrange = { fg = c.orange }
		end,
	},
	init = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "tokyonight*",
			callback = function()
				local lualine_theme = require("lualine.themes.tokyonight")
				for _, mode in pairs(lualine_theme) do
					mode.b.bg = nil
				end
				Config.lualine.create_highlight_groups(lualine_theme)
			end,
		})
	end,
}
