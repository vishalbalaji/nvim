local M = {
	"folke/trouble.nvim",
	enabled = true,
	command = "TroubleToggle",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
}

M.init = function()
	vim.keymap.set("n", "<leader>lt", vim.cmd.TroubleToggle, { noremap = true, silent = true })
	require("config.plugins.colors").safe_hl("TroubleNormal", { link = "NormalAlt" })
end

M.config = function()
	local lsp_sign_icons = require("config.plugins.lsp").lsp_sign_icons
	require("trouble").setup({
		padding = false,
		signs = {
			error = lsp_sign_icons.Error,
			warning = lsp_sign_icons.Warn,
			hint = lsp_sign_icons.hint,
			information = lsp_sign_icons.Info,
			other = lsp_sign_icons.Other,
		},
	})
end

return M
