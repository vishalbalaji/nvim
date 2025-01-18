return {
	"stevearc/dressing.nvim",
	event = "LazyFile",
	opts = {
		input = {
			override = function(conf)
				conf.title = "Rename"
				conf.col = -1
				conf.row = 0
				return conf
			end,
			border = { " " },
			win_options = {
				winblend = 0,
			},
			insert_only = false,
		},

		select = {
			builtin = {
				border = { " " },
				win_options = {
					winblend = 0,
					statuscolumn = " ",
				},
			},
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

	config = function(_, _opts)
		require("dressing").setup(_opts)
		Config.util.hl("DressingSelectIdx", { link = "SpecialComment" })
	end,
}
