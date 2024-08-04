return {
	"folke/todo-comments.nvim",
	event = "LazyFile",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = {
		signs = false,
		keywords = {
			CREDIT = { icon = " ", color = "info", alt = { "REFER" } },
		},
	},
}
