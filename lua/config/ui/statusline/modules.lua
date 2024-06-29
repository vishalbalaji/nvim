---@type table<string, StatuslineModule|fun(...):StatuslineModule>
local M = {}

M.mode = Config.lualine.get_mode

function M.git()
	local g = vim.b.gitsigns_status_dict
	if not g or g.head == "" then
		return ""
	end

	local changes = {}
	if g.added and g.added ~= 0 then
		table.insert(changes, ("%#GitSignsAdd#+" .. g.added))
	end

	if g.changed and g.changed ~= 0 then
		table.insert(changes, ("%#GitSignsChange#~" .. g.changed))
	end

	if g.removed and g.removed ~= 0 then
		table.insert(changes, ("%#GitSignsDelete#-" .. g.removed))
	end

	return table.concat({
		Config.icons.git.Branch,
		" ",
		g.head,
		(#changes > 0 and " " or ""),
	}) .. table.concat(changes, " ")
end

local s = vim.diagnostic.severity
local diagnostic_order = { s.HINT, s.INFO, s.WARN, s.ERROR }
function M.diagnostics()
	local items = {}
	local item_count = 0

	for _, k in ipairs(diagnostic_order) do
		local v = Config.lsp.signs[k]
		local count = vim.tbl_count(vim.diagnostic.get(0, { severity = k }))
		if count > 0 then
			table.insert(items, table.concat({ "%#Diagnostic", v.label, "#", v.icon, " ", count }))
			item_count = item_count + 1
		end
	end

	return table.concat(items, " ")
end

local showcmd_filter = { "h", "j", "k", "l", "i", "o" }
function M.showcmd()
	local text = vim.api.nvim_eval_statusline("%S", {}).str or ""
	local state = vim.fn.state()

	if state == "S" and vim.tbl_contains(showcmd_filter, text) then
		text = ""
	end

	return text
end

function M.macro_recording()
	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	else
		return "Recording @" .. recording_register
	end
end

--Relative path
function M.filename()
	return vim.api.nvim_eval_statusline("%{expand('%:~:.')}", {}).str or ""
end

---@param section string
function M.get_mode_hl(section)
	return function()
		local hl_group = "lualine_" .. section .. Config.lualine.get_mode_suffix()
		return vim.fn.hlexists(hl_group) == 1 and hl_group or ""
	end
end

M.lineinfo = "%p%% %l:%c"

return M
