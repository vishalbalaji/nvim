local pairs = {
	"echasnovski/mini.pairs",
	enabled = true,
	branch = "stable",
	event = "VeryLazy",
	config = require("config.plugins.mini.pairs"),
}

local surround = {
	"echasnovski/mini.surround",
	enabled = true,
	branch = "stable",
	event = "VeryLazy",
	config = require("config.plugins.mini.surround"),
}

local cursorword = {
	"echasnovski/mini.cursorword",
	enabled = true,
	branch = "stable",
	event = "VeryLazy",
	config = require("config.plugins.mini.cursorword"),
}

return {
	pairs,
	surround,
	cursorword,
}
