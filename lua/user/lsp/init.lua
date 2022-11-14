local lspconfig = require("lspconfig")

local icons = require("user.utils.icons")
local handlers = require("user.lsp.handlers")
local on_attach = handlers.on_attach
local capabilities = handlers.capabilities

handlers.setup()
require("mason").setup()
require("user.lsp.cmp")
require("user.lsp.null_ls")

require("trouble").setup({
	padding = false,
	signs = {
		error = icons.diagnostics.Error,
		warning = icons.diagnostics.Warning,
		hint = icons.diagnostics.Hint,
		information = icons.diagnostics.Information,
		other = icons.diagnostics.Question,
	},
})

require("mason-lspconfig").setup_handlers({
	function(server_name) -- default handler (optional)
		local opts = {}

		local read_opts, _opts = pcall(require, "user.lsp.settings." .. server_name)
		if read_opts then
			opts = _opts
		end

		-- sumneko_lua
		if server_name == "sumneko_lua" then
			opts.settings.Lua.diagnostics.workspaceDelay = -1

		-- denols
		elseif server_name == "denols" then
			opts.root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")

			-- tsserver
		elseif server_name == "tsserver" then
			opts.root_dir = lspconfig.util.root_pattern("package.json")
			opts.init_options = {
				preferences = {
					importModuleSpecifierPreference = "non-relative",
				},
			}

		-- pyright
		elseif server_name == "pyright" then
			opts.cmd = { "pyright-langserver", "--stdio" }
			opts.root_pattern = vim.loop.cwd
		end

		opts.on_attach = on_attach
		opts.capabilities = capabilities

		lspconfig[server_name].setup(opts)
	end,
})
