local M = {}

---@param hl_name string
function M.get_hl(hl_name)
	return vim.api.nvim_get_hl(0, { name = hl_name, link = false })
end

---@class ModHLOpts: vim.api.keyset.highlight
---@field set? boolean

-- CREDIT: https://www.reddit.com/r/neovim/comments/wcmqi7/a_simple_utility_function_to_override_and_update/
---@param hl_name string
---@param opts ModHLOpts
function M.mod_hl(hl_name, opts)
	opts = vim.tbl_deep_extend("force", { set = true }, opts)
	local set = opts.set
	opts.set = nil
	local ok, hl_def = pcall(M.get_hl, hl_name)
	if ok then
		for k, v in pairs(opts) do
			hl_def[k] = v
		end
		if set then
			vim.api.nvim_set_hl(0, hl_name, hl_def)
		end
	end

	---@cast hl_def vim.api.keyset.highlight
	return hl_def
end

---@param hl_name string
---@param opts vim.api.keyset.highlight
function M.hl(hl_name, opts)
	local ok, _ = pcall(vim.api.nvim_set_hl, 0, hl_name, opts)
	if not ok then
		print("[DEBUG] Could not highlight: '" .. hl_name .. "'", vim.inspect(opts))
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
