local ui_icons = Config.icons.ui

return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			highlight = "NonText",
			char = ui_icons.LineMiddle,
		},
		scope = {
			char = ui_icons.LineMiddle,
			include = {
				node_type = {
					["*"] = { "return_statement", "ternary_expression", "arguments" },
					lua = { "table_constructor" },
					javascript = { "object", "object_pattern" },
					javascriptreact = { "object", "object_pattern" },
					typescript = { "object", "object_pattern" },
					typescriptreact = { "object", "object_pattern" },
				},
			},
		},
		exclude = {
			filetypes = {
				"help",
				"startify",
				"dashboard",
				"lazy",
				"neogitstatus",
				"NvimTree",
				"Trouble",
				"text",
			},
			buftypes = {
				"terminal",
				"nofile",
			},
		},
	},

	config = function(_, opts)
		local ibl = require("ibl")

		opts.scope.highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}

		vim.g.rainbow_delimiters = { highlight = opts.scope.highlight }
		ibl.setup(opts)
	end,
}
