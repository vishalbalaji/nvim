local M = {
	"lukas-reineke/headlines.nvim",
	enabled = true,
	event = "VeryLazy",
	ft = { "markdown" },
}

M.config = function()
	require("headlines").setup({
		markdown = { fat_headlines = false },
	})

	local c = require("config.plugins.colors")
	local hl = c.safe_hl
	local get_hex = c.get_hex

	local bg_alt = get_hex("NeoTreeNormal", "bg")
	hl("CodeBlock", { bg = bg_alt })
end

return M
