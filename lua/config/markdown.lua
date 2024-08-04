return {
	"MeanderingProgrammer/markdown.nvim",
	ft = { "markdown" },
	name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
	dependencies = {
		require("config.treesitter"),
		require("config.devicons"),
	},
	opts = {
		bullet = {
			icons = { "•", "•", "•", "•" },
		},
	},
	init = function()
		Config.util.hl("RenderMarkdownCode", { link = "NormalAlt" })
	end,
}
