local M = {
	"utilyre/barbecue.nvim",
	enabled = true,
	name = "barbecue",
	version = "*",
	event = "BufReadPost",
	dependencies = {
		"SmiteshP/nvim-navic",
		"kyazdani42/nvim-web-devicons", -- optional dependency
	},
	opts = {
		-- configurations go here
	},
}

return M
