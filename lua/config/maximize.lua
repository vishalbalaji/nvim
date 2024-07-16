return {
	"declancm/maximize.nvim",
	keys = function()
		local maximize = require("maximize")
		return {
			{ "<C-m>", maximize.toggle }
		}
	end,
	config = true,
}
