local M = {
	"tzachar/local-highlight.nvim",
	enabled = true,
	event = "VeryLazy",
}

M.config = function()
	require("local-highlight").setup({
		hlgroup = "Visual",
		cw_hlgroup = nil,
	})

	vim.cmd.LocalHighlightOn()
end

return M
