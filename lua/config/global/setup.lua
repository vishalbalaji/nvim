vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

local M = {}

---@param hlgroup_name string
---@param attr string
function M.get_hex(hlgroup_name, attr)
	local vim_fn = vim.fn

	local hlgroup_ID = vim_fn.synIDtrans(vim_fn.hlID(hlgroup_name))
	local hex = vim_fn.synIDattr(hlgroup_ID, attr)
	return hex ~= "" and hex or "NONE"
end

---@param code string
---@param options table<string, any>
function M.hl(code, options)
	local ok, _ = pcall(vim.api.nvim_set_hl, 0, code, options)
	if not ok then
		print("[DEBUG] Could not highlight: '" .. code .. "'", vim.inspect(options))
	end
end

local icons = require("config.global.icons")

M.icons = icons

M.lsp = require("config.global.lsp")
M.lsp.signs = {
	[-1] = { label = "Other", icon = icons.diagnostics.BoldQuestion },
	[vim.diagnostic.severity.ERROR] = { label = "Error", icon = icons.diagnostics.BoldError },
	[vim.diagnostic.severity.WARN] = { label = "Warn", icon = icons.diagnostics.BoldWarning },
	[vim.diagnostic.severity.HINT] = { label = "Hint", icon = icons.diagnostics.BoldHint },
	[vim.diagnostic.severity.INFO] = { label = "Info", icon = icons.diagnostics.BoldInformation },
}

_G.Config = M
