local M = {
	"stevearc/dressing.nvim",
	enabled = true,
	event = "VeryLazy",
}

M.config = function()
	require("dressing").setup({
		input = {
			win_options = {
				winblend = 0,
			},
			insert_only = false,
		},
	})
end

return M
