local M = {
	"kyazdani42/nvim-web-devicons",
	enabled = true,
	lazy = false,
}

M.config = function ()
	require("nvim-web-devicons").set_icon({
		[".prettierrc"] = {
			icon = "󰫽",
			color = "#F7B93E",
			cterm_color = "65",
			name = "Astro",
		},
		astro = {
			icon = "󰲇",
			color = "#EC682C",
			cterm_color = "65",
			name = "Astro",
		},
	})
end

return M
