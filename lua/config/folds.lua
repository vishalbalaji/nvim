local foldhue = {
	"milisims/foldhue.nvim",
	event = "LazyFile",
	config = function()
		require("foldhue").enable()
	end,
}

local pretty_fold = {
	"anuvyklack/pretty-fold.nvim",
	event = "LazyFile",
	url = "git@github.com:bbjornstad/pretty-fold.nvim.git",
	branch = "master",
	opts = {},
}

return {
	foldhue,
	pretty_fold,
}
