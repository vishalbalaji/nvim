return {
	"stevearc/dressing.nvim",
	event = "LazyFile",
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

		select = {
			get_config = function(opts)
				if opts.kind == "codeaction" then
					return {
						builtin = {
							relative = "cursor",
						},
					}
				end
			end,
		},
	},
}
