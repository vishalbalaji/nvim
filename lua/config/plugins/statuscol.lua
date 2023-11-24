local M = {
	"luukvbaal/statuscol.nvim",
	lazy = false,
	enabled = true,
	event = "VeryLazy",
}

local padding = { text = { " " } }

M.config = function()
	local builtin = require("statuscol.builtin")
	-- print(builtin.lnumfunc())
	require("statuscol").setup({
		ft_ignore = { "neo-tree", "undotree", "Trouble", "man" },
		relculright = false,
		-- configuration goes here, for example:
		segments = {
			{
				sign = { namespace = { "gitsigns" } },
				click = "v:lua.ScSa",
				maxwidth = 1,
			},
			{
				sign = { name = { "Diagnostic" } },
				click = "v:lua.ScSa",
				maxwidth = 1,
				auto = false,
			},
			{
				text = { builtin.lnumfunc },
				click = "v:lua.ScLa",
				auto = true,
			},
			padding,
			{ text = { builtin.foldfunc }, click = "v:lua.ScFa", hl = "IndentBlanklineChar" },
			padding,
		},
	})
end

return M
