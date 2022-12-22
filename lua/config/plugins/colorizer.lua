local M = {
	"NvChad/nvim-colorizer.lua",
	enabled = true,
	cmd = "ColorizerToggle",
}

M.init = function()
	vim.keymap.set("n", "<leader>c", vim.cmd.ColorizerToggle, { silent = true, noremap = true })
end

M.config = function()
	require("colorizer").setup({
		filetypes = { nil },
		user_default_options = {
			tailwind = true,
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			AARRGGBB = true, -- 0xAARRGGBB hex codes
			rgb_fn = true, -- CSS rgb() and rgba() functions
			hsl_fn = true, -- CSS hsl() and hsla() functions
			css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			css_fn = true,
		},
	})
end

return M
