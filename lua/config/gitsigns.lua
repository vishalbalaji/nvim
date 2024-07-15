local function cmul(x, factor)
	if not x or factor == 1 then
		return x
	end

	local r = math.floor(x / 2 ^ 16)
	local x1 = x - (r * 2 ^ 16)
	local g = math.floor(x1 / 2 ^ 8)
	local b = math.floor(x1 - (g * 2 ^ 8))
	return math.floor(math.floor(r * factor) * 2 ^ 16 + math.floor(g * factor) * 2 ^ 8 + math.floor(b * factor))
end

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

		signs_staged = {
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

			print(Config.util.get_hl("GitSignsChange").fg, cmul(Config.util.get_hl("GitSignsChange").fg, 0.5))
			Config.util.hl("GitSignsStagedAdd", { fg = cmul(Config.util.get_hl("GitSignsAdd").fg, 0.5) })
			Config.util.hl("GitSignsStagedChange", { fg = cmul(Config.util.get_hl("GitSignsChange").fg, 0.5) })
			Config.util.hl("GitSignsStagedDelete", { fg = cmul(Config.util.get_hl("GitSignsDelete").fg, 0.5) })
		end,
	},
}
