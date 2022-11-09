local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
	return
end

local status_ok_2, lspconfig = pcall(require, "lspconfig")
if not status_ok_2 then
	return
end

local servers = {
	"bashls",
	"clangd",
	"cssmodules_ls",
	"emmet_ls",
	"html",
	"jsonls",
	"pyright",
	"rust_analyzer",
	"sumneko_lua",
	"tsserver",
	"yamlls",
	-- "jdtls",
	-- "lemminx",
	-- "solc",
	-- "solidity_ls",
	-- "taplo",
	-- "terraformls",
	-- "tflint",
	-- "cssls",
}

local settings = {
	ui = {
		border = "rounded",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local on_attach = require("user.lsp.handlers").on_attach
local capabilities = require("user.lsp.handlers").capabilities

mason_lspconfig.setup_handlers({
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
