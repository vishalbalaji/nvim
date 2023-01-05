local M = {}

M.setup = function()
	require("neodev").setup({
		library = {
			enabled = true,
			runtime = true,
			plugins = { "lazy.nvim" },
		},
	})
end

return M
