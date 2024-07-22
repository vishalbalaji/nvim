return {
	"MeanderingProgrammer/markdown.nvim",
	name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
	dependencies = {
		require("config.treesitter"),
		require("config.devicons"),
	},
	config = function()
		require("render-markdown").setup({})
		Config.util.hl("RenderMarkdownCode", { link = "NormalAlt" })
	end,
}
