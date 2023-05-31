local M = {
	"lewis6991/gitsigns.nvim",
	enabled = true,
	event = "VeryLazy",
}

M.config = function()
	local c = require("config.plugins.colors")
	local colors = c.get_colors()
	local hl = c.safe_hl
	local gs = require("gitsigns")

	gs.setup({
		preview_config = { border = "rounded" },
	})

	hl("DiffAdd", { fg = colors.green })
	hl("DiffChange", { fg = colors.yellow })
	hl("DiffDelete", { fg = colors.red })

	hl("GitSignsAdd", { link = "DiffAdd" })
	hl("GitSignsChange", { link = "DiffChange" })
	hl("GitSignsDelete", { link = "DiffDelete" })

	hl("GitSignsAddInline", { link = "CursorLine" })
	hl("GitSignsAddLnInline", { link = "CursorLine" })
	hl("GitSignsChangeInline", { link = "CursorLine" })
	hl("GitSignsDeleteInline", { link = "CursorLine" })
	hl("GitSignsChangeLnInline", { link = "CursorLine" })
	hl("GitSignsDeleteLnInline", { link = "CursorLine" })
	hl("GitSignsDeleteVirtLnInLine", { link = "CursorLine" })

	local map = require("config.keymaps")

	map("n", "]g", gs.next_hunk)
	map("n", "[g", gs.prev_hunk)
end

return M
