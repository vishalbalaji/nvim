require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
	},
	indent = {enable = {"javascriptreact"}},
}
