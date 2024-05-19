local M = {
	"stevearc/oil.nvim",
	enabled = false,
	event = "VeryLazy",
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

M.config = function()
	require("oil").setup()
end

return M
