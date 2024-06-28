vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

local M = {}

---@param hlgroup_name string
function M.get_hl(hlgroup_name)
	return vim.api.nvim_get_hl(0, {
		name = hlgroup_name,
		link = false,
	})
end

---@param code string
---@param options vim.api.keyset.highlight
function M.hl(code, options)
	local ok, _ = pcall(vim.api.nvim_set_hl, 0, code, options)
	if not ok then
		print("[DEBUG] Could not highlight: '" .. code .. "'", vim.inspect(options))
	end
end

function M.adaptive_split()
	local win = vim.api.nvim_win_get_config(vim.api.nvim_get_current_win())

	if win.width / 4 > win.height then
		vim.cmd.vsplit()
	else
		vim.cmd.split()
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
