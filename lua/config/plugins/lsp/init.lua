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
		require("config.plugins.lsp.conform"),
		require("config.plugins.lsp.nvim-lint"),
		require("config.plugins.lsp.trouble"),
		-- require("config.plugins.lsp.null-ls"),
		-- require("config.plugins.lsp.custom.ccls"),
		-- require("config.plugins.lsp.custom.typescript-tools"),
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

local diagnostic_icons = require("config.icons").diagnostics

M.lsp_sign_icons = {
	Error = diagnostic_icons.BoldError,
	Warn = diagnostic_icons.BoldWarning,
	Hint = diagnostic_icons.BoldHint,
	Info = diagnostic_icons.BoldInformation,
	Other = diagnostic_icons.BoldQuestion,
}

M.inlay_hints_enabled = { "rust", "go", "typescript", "javascript", "typescriptreact", "javascriptreact" }

local map = require("config.keymaps")
M.on_attach = function(_, buffer)
	-- inlay hints
	if vim.tbl_contains(M.inlay_hints_enabled, vim.bo.filetype) then
		-- vim.lsp.buf.inlay_hint(buffer, true)
		map("n", "<leader>lh", function()
			vim.lsp.buf.inlay_hint(buffer)
		end)
	end

	map("n", "<leader>la", vim.lsp.buf.code_action)
	map("x", "<leader>la", vim.lsp.buf.code_action)
	map("n", "<leader>lr", vim.lsp.buf.rename)
	-- map("n", "<leader>lf", function()
	-- 	vim.lsp.buf.format({ async = true })
	-- end)
	map("n", "<leader>ls", vim.lsp.buf.signature_help)
	map("n", "K", vim.lsp.buf.hover)
	map("n", "gd", vim.lsp.buf.definition)
	map("n", "gt", vim.lsp.buf.type_definition)
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

M.disabled_servers = {
	"gopls",
	-- "clangd",  -- disable in favour of ccls
	-- "tsserver", -- disable in favour of typescript-tools
}

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

	local c = require("config.plugins.colors")
	local non_text_fg = c.get_hex("NonText", "fg")

	require("lspconfig.ui.windows").default_options.border = "rounded"
	c.safe_hl("LspInfoBorder", { link = "FloatBorder" })
	c.safe_hl("LspInlayHint", { fg = non_text_fg, bold = true })

	require("mason").setup({ ui = { border = "rounded", height = 0.7 } })
	require("mason-lspconfig").setup()
	require("mason-lspconfig").setup_handlers({
		function(server)
			-- skip disabled servers
			if vim.tbl_contains(M.disabled_servers, server) then
				return
			end

			local settings = servers[server] or {}
			settings.capabilities = capabilities
			settings.on_attach = M.on_attach

			lspconfig[server].setup(settings)
		end,
	})
end

return M
