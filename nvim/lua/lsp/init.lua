local lsp = {}
local map = vim.api.nvim_set_keymap
local cmd = vim.api.nvim_command

local saga = require "lspsaga"

require('lspkind').init()
-- Vsnip
vim.g.vsnip_snippet_dir = "~/.config/nvim/vsnip"

-- LspConfig
cmd [[autocmd ColorScheme * lua require('vim.lsp.diagnostic')._define_default_signs_and_highlights()]]

cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
cmd("command! LspReferences lua vim.lsp.buf.references()")
cmd("command! LspDefinition lua vim.lsp.buf.definition()")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		-- disable virtual text
		virtual_text = true,

		-- show signs
		signs = false,

		-- delay update diagnostics
		update_in_insert = false,
		-- display_diagnostic_autocmds = { "InsertLeave" },

	}
)

-- Lspsaga
saga.init_lsp_saga()

map("n", "<leader>lf", ":LspFormatting<CR>:echo 'Formatted'<CR>", {noremap = true, silent = true})
map("n", "<leader>lr", ":LspReferences<CR>", {noremap = true, silent = true})
map("n", "<leader>ld", ":LspDefinition<CR>:echo 'Jumped to Definition'<CR>", {noremap = true, silent = true})
map("n", "<leader>lh", ":Lspsaga hover_doc<CR>", {noremap = true, silent = true})
map("n", "<F2>", ":Lspsaga rename<CR>", {noremap = true, silent = true})
map("n", "<leader>la", ":Lspsaga code_action<CR>", {noremap = true, silent = true})

return lsp
