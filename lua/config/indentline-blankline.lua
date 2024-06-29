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

		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			Config.util.hl("RainbowRed", { link = "TSRainbowRed" })
			Config.util.hl("RainbowYellow", { link = "TSRainbowYellow" })
			Config.util.hl("RainbowBlue", { link = "TSRainbowBlue" })
			Config.util.hl("RainbowOrange", { link = "TSRainbowOrange" })
			Config.util.hl("RainbowGreen", { link = "TSRainbowGreen" })
			Config.util.hl("RainbowViolet", { link = "TSRainbowViolet" })
			Config.util.hl("RainbowCyan", { link = "TSRainbowCyan" })
		end)

		vim.g.rainbow_delimiters = { highlight = highlight }

		opts.scope.highlight = highlight

		ibl.setup(opts)
	end,
}
