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
	config = function(_, opts)
		require("tokyonight").setup(opts)
		-- Load the colorscheme here.
		-- Like many other themes, this one has different styles, and you could load
		-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
		vim.cmd.colorscheme("tokyonight-night")

		local lualine_theme = require("lualine.themes.tokyonight")
		for _, mode in pairs(lualine_theme) do
			mode.b.bg = nil
		end
		Config.lualine.create_highlight_groups(lualine_theme)

		-- You can configure highlights by doing something like:
		vim.cmd.hi("Comment gui=none")
	end,
}
