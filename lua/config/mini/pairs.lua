return {
	"echasnovski/mini.pairs",
	version = "*",
	event = "InsertEnter",
	config = function()
		require("mini.pairs").setup({})
		vim.api.nvim_set_keymap(
			"i",
			" ",
			[[v:lua.MiniPairs.open('  ', '[%(%[{][%)%]}]')]],
			{ silent = true, expr = true, noremap = true }
		)
	end,
}
