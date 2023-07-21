local M = {
	"pmizio/typescript-tools.nvim",
	enabled = true,
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {
		on_attach = function(_, buffer)
			vim.lsp.buf.inlay_hint(buffer, true)
			-- map("n", "<leader>lh", function()
			-- 	vim.lsp.buf.inlay_hint(buffer)
			-- end)
		end,
		settings = {
			tsserver_file_preferences = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = false,
				includeInlayEnumMemberValueHints = true,
				importModuleSpecifierPreference = "non-relative",
			},
		},
	},
}

return M
