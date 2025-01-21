local M = {}

---@param hl_name string
function M.get_hl(hl_name)
	local ok, hl_def = pcall(vim.api.nvim_get_hl, 0, { name = hl_name, link = false })
	return ok and hl_def or nil
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
	local hl_def = M.get_hl(hl_name)
	if hl_def then
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

---@class HLOpts: vim.api.keyset.highlight
---@field ns_id? number
---@field skip_existing? boolean Skips the hl if the highlight group already exists

---@param hl_name string
---@param opts HLOpts
function M.hl(hl_name, opts)
	opts = vim.tbl_extend("force", { ns_id = 0, skip_existing = false }, opts or {})

	local ns_id = opts.ns_id

	if opts.skip_existing then
		local hl = vim.api.nvim_get_hl(opts.ns_id, { name = hl_name })
		if not vim.tbl_isempty(hl) then
			return
		end
	end

	opts.skip_existing = nil
	opts.ns_id = nil

	local ok, _ = pcall(vim.api.nvim_set_hl, ns_id, hl_name, opts)
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
