local M = {
	"neovim/nvim-lspconfig",
	enabled = true,
	event = "BufReadPre",
	dependencies = {
		{
			"folke/neodev.nvim",
			opts = {
				library = { plugins = false },
				experimental = { pathStrict = true },
			},
		},
		"williamboman/mason.nvim",
		{ "williamboman/mason-lspconfig.nvim", event = "VeryLazy" },

		require("config.plugins.lsp.cmp"),
		require("config.plugins.lsp.null-ls"),
		require("config.plugins.lsp.trouble"),
	},
}

M.opts = {
	-- options for vim.diagnostic.config()
	diagnostics = {
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
		severity_sort = true,
		signs = true,
		underline = true,
		update_in_insert = true,
		virtual_text = false,
	},
	-- Automatically format on save
	autoformat = false,
	-- options for vim.lsp.buf.format
	-- `bufnr` and `filter` is handled by the LazyVim formatter,
	-- but can be also overriden when specified
	format = {
		formatting_options = nil,
		timeout_ms = nil,
	},
}

M.lsp_sign_icons = {
	Error = "✘",
	Warn = "▲",
	Hint = "⚑",
	Info = "",
	Other = "",
}
local map = require("config.keymaps")

local function on_attach()
	map("n", "<leader>la", vim.lsp.buf.code_action)
	map("n", "<leader>lr", vim.lsp.buf.rename)
	map("n", "<leader>lf", function()
		vim.lsp.buf.format({ async = true })
	end)
	map("n", "<leader>ls", vim.lsp.buf.signature_help)
	map("n", "K", vim.lsp.buf.hover)
	map("n", "gd", vim.lsp.buf.definition)
	map("n", "gi", vim.lsp.buf.implementation)
	map("n", "gr", function()
		vim.cmd.TroubleToggle("lsp_references")
	end)
	map("n", "gl", vim.diagnostic.open_float)
	map("n", "[d", vim.diagnostic.goto_prev)
	map("n", "]d", vim.diagnostic.goto_next)
end

M.init = function()
	map("n", "<leader>li", vim.cmd.LspInfo)
	map("n", "<leader>lm", vim.cmd.Mason)
end

M.config = function(_, opts)
	-- diagnostics
	for name, icon in pairs(M.lsp_sign_icons) do
		name = "DiagnosticSign" .. name
		vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
	end
	vim.diagnostic.config(opts.diagnostics)

	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
	local servers = require("config.plugins.lsp.lsp-settings")
	local lspconfig = require("lspconfig")

	require("lspconfig.ui.windows").default_options.border = "rounded"
	require("config.plugins.colors").safe_hl("LspInfoBorder", { link = "FloatBorder" })

	require("mason").setup({ ui = { border = "rounded", height = 0.7 } })
	require("mason-lspconfig").setup()
	require("mason-lspconfig").setup_handlers({
		function(server)
			local settings = servers[server] or {}
			settings.capabilities = capabilities
			settings.on_attach = on_attach

			lspconfig[server].setup(settings)
		end,
	})
end

return M
