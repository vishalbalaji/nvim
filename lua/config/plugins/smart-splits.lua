local M = {
	"mrjones2014/smart-splits.nvim",
	enabled = true,
}

M.keys = {
	{ "<C-s-h>", "<cmd>SmartResizeLeft<CR>" },
	{ "<C-s-l>", "<cmd>SmartResizeRight<CR>" },
	{ "<C-s-k>", "<cmd>SmartResizeUp<CR>" },
	{ "<C-s-j>", "<cmd>SmartResizeDown<CR>" },
}

return M
