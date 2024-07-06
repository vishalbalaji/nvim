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
		local hooks = require("ibl.hooks")

		opts.scope.highlight = {
			"TSRainbowRed",
			"TSRainbowYellow",
			"TSRainbowBlue",
			"TSRainbowOrange",
			"TSRainbowGreen",
			"TSRainbowViolet",
			"TSRainbowCyan",
		}

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { link = "TSRainbowRed" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { link = "TSRainbowYellow" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { link = "TSRainbowBlue" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { link = "TSRainbowOrange" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { link = "TSRainbowGreen" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { link = "TSRainbowViolet" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { link = "TSRainbowCyan" })
		end)
		vim.g.rainbow_delimiters = { highlight = opts.scope.highlight }

		ibl.setup(opts)
	end,
}
