local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

local status_ok_1, null_ls = pcall(require, "null-ls")
if not status_ok_1 then
	return
end

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.completion.spell,
	},
})

require("user.lsp.handlers").setup()

require("user.lsp.mason")
require("user.lsp.lsp-signature")
