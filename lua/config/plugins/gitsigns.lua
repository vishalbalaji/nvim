local M = {
	"lewis6991/gitsigns.nvim",
	enabled = true,
	event = "VeryLazy",
}

function M.config()
	local c = require("config.plugins.colors")
	local colors = c.get_colors()
	local hl = c.hl

	require("gitsigns").setup({
		preview_config = { border = "rounded" },
	})

	hl("DiffAdd", { fg = colors.green })
	hl("DiffChange", { fg = colors.yellow })
	hl("DiffDelete", { fg = colors.red })
	hl("GitSignsAdd", { link = "DiffAdd" })
	hl("GitSignsChange", { link = "DiffChange" })
	hl("GitSignsDelete", { link = "DiffDelete" })
end

return M
