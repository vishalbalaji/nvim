local M = {
	"folke/todo-comments.nvim",
	enabled = true,
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = {
		keywords = {
			CREDIT = { icon = " ", color = "info" },
		},
	},
}

return M
