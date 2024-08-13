local foldhue = {
	"milisims/foldhue.nvim",
	event = "LazyFile",
	config = function()
		require("foldhue").enable()
	end,
}

local pretty_fold = {
	"bbjornstad/pretty-fold.nvim",
	-- "anuvyklack/pretty-fold.nvim",
	-- url = "git@github.com:bbjornstad/pretty-fold.nvim.git",
	event = "LazyFile",
	branch = "master",
	opts = {},
}

return {
	foldhue,
	pretty_fold,
}
