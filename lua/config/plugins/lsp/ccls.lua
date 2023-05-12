local M = {
	"ranjithshegde/ccls.nvim",
	enabled = true,
	event = "VeryLazy",
}

M.config = function()
	local util = require("lspconfig.util")

	local server_config = {
		filetypes = { "c", "cpp", "objc", "objcpp", "opencl" },
		root_dir = function(fname)
			return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")(fname)
					or util.find_git_ancestor(fname)
		end,
		init_options = {
			cache = {
				directory = vim.fs.normalize("~/.cache/ccls"),
				-- directory = vim.env.XDG_CACHE_HOME .. "/ccls/",
				-- or vim.fs.normalize "~/.cache/ccls" -- if on nvim 0.8 or higher
			},
		},
		on_attach = require("config.plugins.lsp").on_attach,
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}

	require("ccls").setup({ lsp = { lspconfig = server_config } })
end

return M
