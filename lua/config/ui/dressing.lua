return {
	"stevearc/dressing.nvim",
	event = "LazyFile",
	opts = {
		input = {
			prompt = "Rename",
			override = function(conf)
				conf.col = -1
				conf.row = 0
				return conf
			end,
			border = { " " },
			win_options = {
				winblend = 0,
				-- adds padding at the left border
				statuscolumn = " ",
				winhighlight = "NormalFloat:Normal",
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

	config = function(_, _opts)
		require("dressing").setup(_opts)
		local input = vim.ui.input
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.input = function(opts, on_confirm)
			if _opts.input.prompt then
				opts.prompt = _opts.input.prompt
			end
			input(opts, on_confirm)
		end
	end,
}
