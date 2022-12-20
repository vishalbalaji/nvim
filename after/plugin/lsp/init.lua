local lsp = require("lsp-zero")

lsp.preset("lsp-compe")
lsp.set_preferences({
	set_lsp_keymaps = false,
	sign_icons = _G.lsp_sign_icons,
})

lsp.ensure_installed({
	"tsserver",
	"sumneko_lua",
})

-- Trouble
require("trouble").setup({
	padding = false,
	signs = {
		error = _G.lsp_sign_icons.error,
		warning = _G.lsp_sign_icons.warn,
		hint = _G.lsp_sign_icons.hint,
		information = _G.lsp_sign_icons.info,
		other = _G.lsp_sign_icons.other,
	},
})

-- Diagnostics
require("lspconfig.ui.windows").default_options.border = "rounded"

vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })

-- Keymaps
-- -- LSP Actions
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

-- -- Diagnostics
vim.diagnostic.config({
	update_in_insert = true,
})

map("n", "gl", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)

-- LSP
local settings = require("lsp.settings").get_settings()

-- local neodev = require("neodev").setup()
-- print(vim.inspect(neodev))

lsp.configure("sumneko_lua", settings.sumneko_lua)
lsp.configure("tsserver", settings.tsserver)

lsp.setup()
require("lsp.cmp").setup(lsp)
require("lsp.null-ls").setup(lsp)
