local lsp = require("lsp-zero")
lsp.preset("lsp-compe")

lsp.set_preferences({
	set_lsp_keymaps = false,
})

lsp.ensure_installed({
	"tsserver",
	"sumneko_lua",
})

-- Trouble
require("trouble").setup({
	padding = false,
})

-- Diagnostics
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

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
map("n", "gl", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)

-- LSP
vim.diagnostic.config({
	update_in_insert = true,
})

local settings = require("lsp.settings").get_settings()

lsp.configure("sumneko_lua", settings.sumneko_lua)
lsp.configure("tsserver", settings.tsserver)

lsp.setup()
require("lsp.cmp").setup()
require("lsp.null-ls").setup()