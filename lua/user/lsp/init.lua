local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("lsp-inlayhints").setup()
require("user.lsp.handlers").setup()
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.lsp.buf.format({ async = false })
-- 	end,
-- })

-- autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
require("user.lsp.mason")
-- require("user.lsp.lsp-signature")
require("user.lsp.null_ls")
