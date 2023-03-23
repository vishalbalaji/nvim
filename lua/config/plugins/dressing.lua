local M = {
	"stevearc/dressing.nvim",
	enabled = true,
	event = "VeryLazy",
}

M.config = function()
	require("dressing").setup({
		input = {
			override = function(conf)
				conf.col = -1
				conf.row = 0
				return conf
			end,
			win_options = {
				winblend = 0,
			},
			insert_only = false,
		},
	})
end

return M
