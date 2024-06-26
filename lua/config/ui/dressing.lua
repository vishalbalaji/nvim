return {
	"stevearc/dressing.nvim",
	opts = {
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
	},
}
