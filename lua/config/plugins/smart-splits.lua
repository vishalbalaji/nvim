local M = {
	"mrjones2014/smart-splits.nvim",
	enabled = true,
	event = "VeryLazy",
}

M.config = function()
	local smart_splits = require("smart-splits")
	vim.keymap.set("n", "<C-S-h>", smart_splits.resize_left, { noremap = true, silent = true })
	vim.keymap.set("n", "<C-S-l>", smart_splits.resize_right, { noremap = true, silent = true })
	vim.keymap.set("n", "<C-S-k>", smart_splits.resize_up, { noremap = true, silent = true })
	vim.keymap.set("n", "<C-S-j>", smart_splits.resize_down, { noremap = true, silent = true })
end

return M
