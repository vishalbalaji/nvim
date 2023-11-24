local M = {
	"booperlv/nvim-gomove",
	enabled = true,
	event = "VeryLazy",
	enabled = false,
}

M.config = function()
	require("gomove").setup({
		map_defaults = false,
	})
end

return M
