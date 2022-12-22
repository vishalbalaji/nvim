local foldhue = {
	"milisims/foldhue.nvim",
	enabled = true,
	event = "VeryLazy",
	config = function()
		require("foldhue").enable()
	end,
}

local pretty_fold = {
	"anuvyklack/pretty-fold.nvim",
	event = "VeryLazy",
	config = function()
		require("pretty-fold").setup({})
	end,
}

return {
	foldhue,
	pretty_fold,
}
