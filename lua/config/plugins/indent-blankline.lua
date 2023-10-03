local M = {
	"lukas-reineke/indent-blankline.nvim",
	enabled = true,
	event = "BufReadPre",
}

function M.config()
	local indent = require("ibl")
	local ui_icons = require("config.icons").ui
	local hooks = require("ibl.hooks")
	local colors = require("config.plugins.colors").get_colors()

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
		vim.api.nvim_set_hl(0, "RainbowRed", { fg = colors.red })
		vim.api.nvim_set_hl(0, "RainbowYellow", { fg = colors.yellow })
		vim.api.nvim_set_hl(0, "RainbowBlue", { fg = colors.blue })
		vim.api.nvim_set_hl(0, "RainbowOrange", { fg = colors.orange })
		vim.api.nvim_set_hl(0, "RainbowGreen", { fg = colors.green })
		vim.api.nvim_set_hl(0, "RainbowViolet", { fg = colors.magenta })
		vim.api.nvim_set_hl(0, "RainbowCyan", { fg = colors.cyan })
	end)
	vim.g.rainbow_delimiters = { highlight = highlight }

	indent.setup({
		indent = {
			highlight = "NonText",
			char = ui_icons.LineMiddle,
		},
		scope = {
			highlight = highlight,
			char = ui_icons.LineMiddle,
			include = {
				node_type = {
					["*"] = { "return_statement", "ternary_expression" },
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
	})
end

return M
