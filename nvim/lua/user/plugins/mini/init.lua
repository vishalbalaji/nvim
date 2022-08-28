require("user.plugins.mini.comment").setup({
	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		-- Toggle comment (like `gcip` - comment inner paragraph) for both
		-- Normal and Visual modes
		comment = "gc",

		-- Toggle comment on current line
		comment_line = "gcc",

		-- Define 'comment' textobject (like `dgc` - delete whole comment block)
		textobject = "",
	},
})

require("user.plugins.mini.pairs").setup({})
