local M = {
	"tzachar/local-highlight.nvim",
	enabled = true,
	event = "VeryLazy",
}

M.config = function()
	local c = require("config.plugins.colors")
	local visual_bg =  c.get_hex("Visual", "bg")

	c.safe_hl("LocalHighlight", { bg = visual_bg })

	require("local-highlight").setup({
		hlgroup = "LocalHighlight",
		cw_hlgroup = nil,
	})

	vim.cmd.LocalHighlightOn()
end

return M
