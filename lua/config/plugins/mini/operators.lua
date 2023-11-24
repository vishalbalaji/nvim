local M = {
	"echasnovski/mini.operators",
	enabled = true,
	branch = "stable",
	event = "VeryLazy",
	config = {
		evaluate = { prefix = "m=" },

		-- Exchange text regions
		exchange = { prefix = "mx" },

		-- Multiply (duplicate) text
		multiply = { prefix = "mm" },

		-- Replace text with register
		replace = { prefix = "mr" },

		-- Sort text
		sort = { prefix = "ms" },
	},
}

return M
