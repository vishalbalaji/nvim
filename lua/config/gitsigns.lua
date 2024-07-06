return {
	"lewis6991/gitsigns.nvim",
	event = "LazyFile",
	dependencies = {
		require("config.colorscheme"),
	},
	keys = {
		{ "]g", "<cmd>Gitsigns next_hunk<CR>" },
		{ "[g", "<cmd>Gitsigns prev_hunk<CR>" },
	},
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},

		on_attach = function()
			Config.util.hl("GitSignsAdd", { link = "TSRainbowGreen" })
			Config.util.hl("GitSignsChange", { link = "TSRainbowYellow" })
			Config.util.hl("GitSignsDelete", { link = "TSRainbowRed" })
		end,
	},
}
