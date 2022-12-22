local M = {}

M.setup = function()
	require("neodev").setup({
		library = {
			enabled = true,
			plugins = { "lazy.nvim" },
		},
	})
end

return M
