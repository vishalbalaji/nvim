local lsp_signs = Config.lsp.signs or {}

---@param diagnostic vim.Diagnostic
local function get_sign_icon(diagnostic)
	return (lsp_signs[diagnostic.severity] or lsp_signs[-1]).icon
end

local mason = require("config.code.mason")

return { -- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	event = "LazyFile",
	dependencies = {
		mason, -- NOTE: Must be loaded before dependants

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

	keys = {
		{ "<leader>li", vim.cmd.LspInfo, desc = "[L]SP: [I]nfo" },
		{ "[d", vim.diagnostic.goto_prev, desc = "[L]SP: Go to previous [D]iagnostic message" },
		{ "]d", vim.diagnostic.goto_next, desc = "[L]SP: Go to next [D]iagnostic message" },
		{ "L", vim.diagnostic.open_float, desc = "[L]SP: Show diagnostic error messages in float" },
		{ "<leader>lq", vim.diagnostic.setloclist, desc = "[L]SP: Open diagnostic [Q]uickfix list" },
	},

	opts = function()
		local util = require("lspconfig").util

		return {
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
					-- border = "rounded",
					source = false,
					prefix = "",
					format = function(diagnostic)
						local icon = get_sign_icon(diagnostic)
						return icon .. " " .. diagnostic.source .. ": " .. diagnostic.message
					end,
				},
				severity_sort = true,
				signs = true,
				underline = true,
			},

			--- Server Config
			servers = {
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
				svelte = {
					on_attach = function(client)
						-- TODO: Send a notification here.
						-- Check what kind of notification is used
						-- by tsserver
						-- vim.notify("Whaat")
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							callback = function(ctx)
								client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
							end,
						})
					end,
				},
			},
		}
	end,
	config = function(_, opts)
		-- [DIAGNOSTICS SETUP START] ---
		for _, d in pairs(lsp_signs) do
			local name = "DiagnosticSign" .. d.label
			vim.fn.sign_define(name, { text = d.icon, texthl = name, numhl = "" })
		end

		Config.util.hl("DiagnosticHint", { link = "RainbowGreen" })
		Config.util.hl("DiagnosticOk", { link = "RainbowGreen" })
		Config.util.hl("DiagnosticInfo", { link = "RainbowBlue" })
		Config.util.hl("DiagnosticWarn", { link = "RainbowYellow" })
		Config.util.hl("DiagnosticError", { link = "RainbowRed" })

		Config.util.hl("DiagnosticVirtualTextHint", { link = "DiagnosticHint" })
		Config.util.hl("DiagnosticVirtualTextOk", { link = "DiagnosticOk" })
		Config.util.hl("DiagnosticVirtualTextInfo", { link = "DiagnosticInfo" })
		Config.util.hl("DiagnosticVirtualTextWarn", { link = "DiagnosticWarn" })
		Config.util.hl("DiagnosticVirtualTextError", { link = "DiagnosticError" })

		local ok_fg = Config.util.get_hl("DiagnosticOk").fg
		local hint_fg = Config.util.get_hl("DiagnosticHint").fg
		local info_fg = Config.util.get_hl("DiagnosticInfo").fg
		local warn_fg = Config.util.get_hl("DiagnosticWarn").fg
		local error_fg = Config.util.get_hl("DiagnosticError").fg

		Config.util.hl("DiagnosticUnderlineOk", { undercurl = true, special = ok_fg })
		Config.util.hl("DiagnosticUnderlineHint", { undercurl = true, special = hint_fg })
		Config.util.hl("DiagnosticUnderlineInfo", { undercurl = true, special = info_fg })
		Config.util.hl("DiagnosticUnderlineWarn", { undercurl = true, special = warn_fg })
		Config.util.hl("DiagnosticUnderlineError", { undercurl = true, special = error_fg })

		Config.util.hl("LspSignatureActiveParameter", { link = "CursorLine" })

		vim.diagnostic.config(opts.diagnostics)
		--
		-- [DIAGNOSTICS SETUP END] ---

		-- require("lspconfig.ui.windows").default_options.border = "rounded"

		Config.util.hl("LspInfoBorder", { link = "FloatBorder" })
		Config.util.hl("LspInlayHint", { fg = Config.util.get_hl("NonText").fg, bold = true })

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

				map("<leader>ls", vim.lsp.buf.signature_help, "[S]ignature")

				-- Opens a popup that displays documentation about the word under your cursor
				--  See `:help K` for why this keymap.
				map("K", vim.lsp.buf.hover, "Hover Documentation")

				map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

				map("gd", function()
					vim.lsp.buf.definition({ reuse_win = true })
				end, "[G]oto [D]efinition")

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header.
				map("gD", function()
					vim.lsp.buf.declaration({ reuse_win = true })
				end, "[G]oto [D]efinition")

				-- map("gd", function()
				-- 	vim.lsp.buf.definition({
				-- 		reuse_win = true,
				-- 		on_list = function(options)
				-- 			if #options.items > 1 then
				-- 				vim.fn.setqflist({}, " ", options)
				-- 				vim.cmd.copen()
				-- 			else
				-- 				if options.items[0].ro
				-- 			end
				-- 		end,
				-- 	})
				-- end, "[G]oto [D]efinition")

				-- map("gD", function()
				-- 	vim.lsp.buf.declaration({
				-- 		reuse_win = true,
				-- 		on_list = function(options)
				-- 			Config.adaptive_split()
				-- 			vim.fn.setqflist({}, " ", options)
				-- 			if #options.items > 1 then
				-- 				vim.cmd.copen()
				-- 			else
				-- 				vim.cmd.cfirst()
				-- 			end
				-- 		end,
				-- 	})
				-- end, "[G]oto [D]eclaration")

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

		-- CMP
		pcall(function()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		end)

		-- BLINK
		pcall(function()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
		end)

		-- Ensure the servers and tools above are installed
		--  To check the current status of installed tools and/or manually install
		--  other tools, you can run
		--    :Mason
		--
		--  You can press `g?` for help in this menu.
		mason.setup(opts.servers, capabilities)
	end,
}
