return function()
	require("mini.pairs").setup({})
	vim.api.nvim_set_keymap(
		"i",
		" ",
		[[v:lua.MiniPairs.open('  ', '[%(%[{][%)%]}]')]],
		{ silent = true, expr = true, noremap = true }
	)
end
