return {
	"brenoprata10/nvim-highlight-colors",
	cmd = "HiglightColors",
	keys = {
		{ "<leader>c", "<cmd>HighlightColors toggle<CR>" },
	},
	opts = {
		virtual_symbol_suffix = " ",
		render = "virtual",
		virtual_symbol_position = "inline",
		enable_tailwind = true,
	},
	config = function(_, opts)
		local highlight = require("nvim-highlight-colors")
		highlight.setup(opts)
		highlight.turnOff()
	end,
}
