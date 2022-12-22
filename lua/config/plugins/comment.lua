local M = {
	"numToStr/Comment.nvim",
	enabled = true,
	event = "VeryLazy",
}

M.config = function()
	require("Comment").setup({
		-- pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		ignore = "^$",
		mappings = {
			basic = false,
			extra = false,
		},
	})
	vim.keymap.set("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", { silent = true, noremap = true })
	vim.keymap.set("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)gv", { silent = true, noremap = true })
end

return M
