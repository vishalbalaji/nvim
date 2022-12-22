local M = {}
M.setup = function()
	local lsp_sign_icons = require("config.plugins.lsp").lsp_sign_icons
	require("trouble").setup({
		padding = false,
		signs = {
			error = lsp_sign_icons.error,
			warning = lsp_sign_icons.warn,
			hint = lsp_sign_icons.hint,
			information = lsp_sign_icons.info,
			other = lsp_sign_icons.other,
		},
	})

	local hl = require("config.plugins.colors").hl
	hl("TroubleNormal", { link = "NormalAlt" })
end
return M
