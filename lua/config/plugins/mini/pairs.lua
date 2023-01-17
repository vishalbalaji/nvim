local M = {
	"echasnovski/mini.pairs",
	enabled = true,
	branch = "stable",
	event = "VeryLazy",
}

M.config = function()
	require("mini.pairs").setup({})
	vim.api.nvim_set_keymap(
		"i",
		" ",
		[[v:lua.MiniPairs.open('  ', '[%(%[{][%)%]}]')]],
		{ silent = true, expr = true, noremap = true }
	)
end

return M
