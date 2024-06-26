local lsp_signs = Config.lsp.signs or {}

local function get_sign_icon(diagnostic)
	if diagnostic.severity == vim.diagnostic.severity.ERROR then
		return lsp_signs.Error
	elseif diagnostic.severity == vim.diagnostic.severity.WARN then
		return lsp_signs.Warn
	elseif diagnostic.severity == vim.diagnostic.severity.INFO then
		return lsp_signs.Info
	elseif diagnostic.severity == vim.diagnostic.severity.HINT then
		return lsp_signs.Hint
	else
		return lsp_signs.Other
	end
end

local mason = require("config.code.mason")

return { -- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	event = "LazyFile",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		mason, -- NOTE: Must be loaded before dependants

		-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		-- Use neodev-types with lazydev
		{ "folke/neodev.nvim", config = function() end },
		{
			"folke/lazydev.nvim",
			opts = function(_, opts)
				opts.library = opts.library or {}
				table.insert(opts.library, { "neodev.nvim/types/stable" })
			end,
			config = function(_, opts)
				-- force lazydev to load on Neovim 0.9
				require("lazydev.config").have_0_10 = true
				require("lazydev").setup(opts)
			end,
		},
	},
	opts = {
		---@type vim.diagnostic.Opts
		diagnostics = {
			virtual_text = {
				source = true,
				prefix = function(diagnostic, i, total)
					local icon = get_sign_icon(diagnostic)
					if i < total then
						icon = icon .. " "
					end

					return icon
				end,
			},
			float = {
				header = "",
				border = "rounded",
				source = false,
				format = function(diagnostic)
					local icon = get_sign_icon(diagnostic)
					return icon .. " " .. diagnostic.source .. ": " .. diagnostic.message
				end,
			},
			severity_sort = true,
			signs = true,
			underline = true,
		},
	},
	keys = {
		{ "<leader>li", vim.cmd.LspInfo, desc = "[L]SP: [I]nfo" },
		{ "[d", vim.diagnostic.goto_prev, desc = "[L]SP: Go to previous [D]iagnostic message" },
		{ "]d", vim.diagnostic.goto_next, desc = "[L]SP: Go to next [D]iagnostic message" },
		{ "<leader>le", vim.diagnostic.open_float, desc = "[L]SP: Show diagnostic [E]rror messages" },
		{ "<leader>lq", vim.diagnostic.setloclist, desc = "[L]SP: Open diagnostic [Q]uickfix list" },
	},
	config = function(_, opts)
		-- Diagnostics setup
		for name, icon in pairs(lsp_signs) do
			name = "DiagnosticSign" .. name
			vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
		end

		vim.diagnostic.config(opts.diagnostics)

		-- Brief aside: **What is LSP?**
		--
		-- LSP is an initialism you've probably heard, but might not understand what it is.
		--
		-- LSP stands for Language Server Protocol. It's a protocol that helps editors
		-- and language tooling communicate in a standardized fashion.
		--
		-- In general, you have a "server" which is some tool built to understand a particular
		-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
		-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
		-- processes that communicate with some "client" - in this case, Neovim!
		--
		-- LSP provides Neovim with features like:
		--  - Go to definition
		--  - Find references
		--  - Autocompletion
		--  - Symbol Search
		--  - and more!
		--
		-- Thus, Language Servers are external tools that must be installed separately from
		-- Neovim. This is where `mason` and related plugins come into play.
		--
		-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
		-- and elegantly composed help section, `:help lsp-vs-treesitter`

		--  This function gets run when an LSP attaches to a particular buffer.
		--    That is to say, every time a new file is opened that is associated with
		--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
		--    function will be executed to configure the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf or nil, desc = "[L]SP: " .. desc })
				end

				-- Rename the variable under your cursor.
				--  Most Language Servers support renaming across files, etc.
				map("<leader>lr", vim.lsp.buf.rename, "[R]ename")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("<leader>la", vim.lsp.buf.code_action, "Code [A]ction")

				-- Opens a popup that displays documentation about the word under your cursor
				--  See `:help K` for why this keymap.
				map("K", vim.lsp.buf.hover, "Hover Documentation")

				map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

				map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header.
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					local highlight_augroup = vim.api.nvim_create_augroup("custom-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("custom-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "custom-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- The following autocommand is used to enable inlay hints in your
				-- code, if the language server you are using supports them
				--
				-- This may be unwanted, since they displace some of your code
				if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local util = require("lspconfig").util

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			-- clangd = {},
			-- gopls = {},
			-- pyright = {},
			-- rust_analyzer = {},
			-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
			--
			-- Some languages (like typescript) have entire language plugins that can be useful:
			--    https://github.com/pmizio/typescript-tools.nvim
			--
			-- But for many setups, the LSP (`tsserver`) will work just fine
			-- tsserver = {},
			--

			lua_ls = {
				-- cmd = {...},
				-- filetypes = { ...},
				-- capabilities = {},
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						-- diagnostics = { disable = { 'missing-fields' } },
					},
				},
			},
			tailwindcss = {
				root_dir = util.root_pattern(
					"tailwind.config.*js",
					"tailwind.config.*ts",
					"postcss.config.*js",
					"postcss.config.*ts"
				),
			},
		}

		-- Ensure the servers and tools above are installed
		--  To check the current status of installed tools and/or manually install
		--  other tools, you can run
		--    :Mason
		--
		--  You can press `g?` for help in this menu.
		mason.setup(servers, capabilities)
	end,
}
