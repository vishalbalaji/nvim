return {
	"vishalbalaji/nvim-colorizer.lua",

	-- name = "nvim-colorizer",
	-- dir = "~/projects/nvim-colorizer.lua",
	-- dev = true,

	enabled = false,
	cmd = { "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers", "ColorizerToggle" },
	keys = {
		{ "<leader>c", "<cmd>ColorizerToggle<CR>" },
	},
	opts = {
		filetypes = { nil },
		user_default_options = {
			mode = "virtualtext",
			virtualtext = Config.icons.ui.Circle,
			virtualtext_inline = true,
			tailwind = "both",
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			AARRGGBB = true, -- 0xAARRGGBB hex codes
			rgb_fn = true, -- CSS rgb() and rgba() functions
			hsl_fn = true, -- CSS hsl() and hsla() functions
			css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			css_fn = true,
		},
	},
}
