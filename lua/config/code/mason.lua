local M = {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	cmd = "Mason",
	keys = {
		{ "<leader>lm", vim.cmd.Mason, desc = "[L]SP: [M]ason" },
	},
	---@type MasonSettings
	opts = {
		ui = {
			border = "rounded",
			height = 0.8,
		},
	},
	config = function() end,
}

function M.setup(servers, capabilities)
	require("mason").setup(M.opts)

	-- You can add other tools here that you want Mason to install
	-- for you, so that they are available from within Neovim.
	local ensure_installed = vim.tbl_keys(servers or {})
	vim.list_extend(ensure_installed, {
		"stylua", -- Used to format Lua code
	})

	require("mason-tool-installer").setup({})
	-- require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				-- This handles overriding only values explicitly passed
				-- by the server configuration above. Useful when disabling
				-- certain features of an LSP (for example, turning off formatting for tsserver)
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				require("lspconfig")[server_name].setup(server)
			end,
		},
	})
end

return M
