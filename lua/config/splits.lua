return {
	{
		"mrjones2014/smart-splits.nvim",
		keys = {
			{ "<C-s-h>", "<cmd>SmartResizeLeft<CR>" },
			{ "<C-s-l>", "<cmd>SmartResizeRight<CR>" },
			{ "<C-s-k>", "<cmd>SmartResizeUp<CR>" },
			{ "<C-s-j>", "<cmd>SmartResizeDown<CR>" },
		},
	},
	{
		"declancm/maximize.nvim",
		enabled = true,
		cmd = "Maximize",
		keys = function()
			local maximize = require("maximize")
			return {
				{ "<C-m>", maximize.toggle },
			}
		end,
		config = true,
	},
}
