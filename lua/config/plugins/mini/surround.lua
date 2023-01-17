local M = {
	"echasnovski/mini.surround",
	enabled = true,
	branch = "stable",
	event = "VeryLazy",
}

M.config = function()
	require("mini.surround").setup({
		mappings = {
			add = "<leader>sa", -- Add surrounding in Normal and Visual modes
			delete = "<leader>sd", -- Delete surrounding
			find = "]", -- Find surrounding (to the right)
			find_left = "[", -- Find surrounding (to the left)
			highlight = "<leader>sh", -- Highlight surrounding
			replace = "<leader>sr", -- Replace surrounding
			update_n_lines = "<leader>sn", -- Update `n_lines`
		},
	})
end

return M
