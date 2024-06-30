return {
	"luukvbaal/statuscol.nvim",
	dependencies = {
		require("config.gitsigns"),
	},
	opts = function()
		local builtin = require("statuscol.builtin")
		local padding = { text = { " " } }

		return {
			ft_ignore = { "neo-tree" }, -- lua table with 'filetype' values for which 'statuscolumn' will be unset
			segments = {
				{
					sign = { namespace = { "gitsigns" } },
					click = "v:lua.ScSa",
				},
				{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
				{
					sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
					click = "v:lua.ScSa",
				},
				padding,
				{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				padding,
			},
		}
	end,
}
