return {
	"numToStr/Comment.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	keys = {
		{ "<C-/>", "<Plug>(comment_toggle_linewise_current)" },
		{ "<C-/>", "<Plug>(comment_toggle_linewise_visual)gv", mode = "v" },
	},
	config = function()
		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			ignore = "^$",
			mappings = {
				basic = false,
				extra = false,
			},
		})
	end,
}
