local M = {
	"VonHeikemen/lsp-zero.nvim",
	enabled = true,
	event = "VeryLazy",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig", event = "BufReadPre" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- Utils
		{ "folke/neodev.nvim" },
		{ "folke/trouble.nvim" },

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-cmdline" },
		{ "hrsh7th/cmp-emoji" },

		-- Snippets
		{ "L3MON4D3/LuaSnip" },
		{ "rafamadriz/friendly-snippets" },

		-- NullLS
		{ "jose-elias-alvarez/null-ls.nvim" },
	},
}

M.lsp_sign_icons = {
	error = "✘",
	warn = "▲",
	hint = "⚑",
	info = "",
	other = "",
}

local function on_attach()
	local function map(mode, key, mapping)
		local opts = { noremap = true, silent = true }
		vim.keymap.set(mode, key, mapping, opts)
	end

	map("n", "<leader>la", vim.lsp.buf.code_action)
	map("n", "<leader>lr", vim.lsp.buf.rename)
	map("n", "<leader>lf", vim.cmd.LspZeroFormat)
	map("n", "<leader>li", vim.cmd.LspInfo)
	map("n", "<leader>lm", vim.cmd.Mason)
	map("n", "<leader>lt", vim.cmd.TroubleToggle)
	map("n", "<leader>lr", vim.lsp.buf.rename)
	map("n", "<leader>ls", vim.lsp.buf.signature_help)
	map("n", "K", vim.lsp.buf.hover)
	map("n", "gd", vim.lsp.buf.definition)
	map("n", "gr", function()
		vim.cmd.TroubleToggle("lsp_references")
	end)
	map("n", "gl", vim.diagnostic.open_float)
	map("n", "[d", vim.diagnostic.goto_prev)
	map("n", "]d", vim.diagnostic.goto_next)
end

-- LSP Highlights
local function lsp_hls()
	local c = require("config.plugins.colors")
	local colors = c.get_colors()
	local hl = c.hl

	hl("LspInlayHint", { fg = colors.comment_fg, bg = "bg", bold = true })
	hl("DiagnosticError", { fg = colors.red })
	hl("DiagnosticWarn", { fg = colors.yellow })
	hl("DiagnosticInfo", { fg = colors.blue })
	hl("DiagnosticHint", { fg = colors.green })
	hl("DiagnosticUnderlineError", { undercurl = true, fg = colors.red })
end

M.config = function()
	local lsp = require("lsp-zero")

	lsp.preset("lsp-compe")
	lsp.set_preferences({
		set_lsp_keymaps = false,
		sign_icons = M.lsp_sign_icons,
	})
	vim.diagnostic.config({
		update_in_insert = true,
	})

	require("lspconfig.ui.windows").default_options.border = "rounded"
	vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })

	lsp.on_attach(on_attach)

	local settings = require("config.plugins.lsp.lsp-settings")
	lsp.configure("sumneko_lua", settings.sumneko_lua)
	lsp.configure("tsserver", settings.tsserver)
	lsp.configure("denols", settings.denols)
	lsp.configure("pyright", settings.pyright)
	lsp.configure("tailwindcss", settings.tailwindcss)

	-- require("config.plugins.lsp.neodev").setup()
	lsp.setup()
	require("config.plugins.lsp.cmp").setup(lsp)
	require("config.plugins.lsp.null-ls").setup(lsp)
	require("config.plugins.lsp.trouble").setup()

	lsp_hls()
end

return M
