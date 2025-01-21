local function init_hls()
	Config.util.hl("RainbowRed", { fg = "red", skip_existing = true })
	Config.util.hl("RainbowGreen", { fg = "green", skip_existing = true })
	Config.util.hl("RainbowYellow", { fg = "yellow", skip_existing = true })
	Config.util.hl("RainbowBlue", { fg = "blue", skip_existing = true })
	Config.util.hl("RainbowViolet", { fg = "violet", skip_existing = true })
	Config.util.hl("RainbowCyan", { fg = "cyan", skip_existing = true })
	Config.util.hl("RainbowOrange", { fg = "orange", skip_existing = true })
end

return {
	name = "colorscheme",
	virtual = true,
	priority = 1000,
	dir = "config.colorscheme",
	dependencies = {
		require("config.colorscheme.everblush"),
		require("config.colorscheme.tokyonight"),
		require("config.colorscheme.github"),
	},
	opts = {
		colorscheme = "github_dark_default",
		fallback_colorscheme = "wildcharm",
	},
	init = function()
		init_hls()
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				init_hls()
			end,
		})
	end,
	config = function(_, opts)
		local ok, _ = pcall(vim.cmd.colorscheme, opts.colorscheme)
		if not ok then
			vim.cmd.colorscheme(opts.fallback_colorscheme)
		end
	end,
}
