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

return M
