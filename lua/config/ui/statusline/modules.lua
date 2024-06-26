-- stylua: ignore
local mode_map = {
  ['n']      = 'NORMAL',
  ['no']     = 'O-PENDING',
  ['nov']    = 'O-PENDING',
  ['noV']    = 'O-PENDING',
  ['no\22'] = 'O-PENDING',
  ['niI']    = 'NORMAL',
  ['niR']    = 'NORMAL',
  ['niV']    = 'NORMAL',
  ['v']      = 'VISUAL',
  ['vs']     = 'VISUAL',
  ['V']      = 'V-LINE',
  ['Vs']     = 'V-LINE',
  ['\22']   = 'V-BLOCK',
  ['\22s']  = 'V-BLOCK',
  ['s']      = 'SELECT',
  ['S']      = 'S-LINE',
  ['\19']   = 'S-BLOCK',
  ['i']      = 'INSERT',
  ['ic']     = 'INSERT',
  ['ix']     = 'INSERT',
  ['R']      = 'REPLACE',
  ['Rc']     = 'REPLACE',
  ['Rx']     = 'REPLACE',
  ['Rv']     = 'V-REPLACE',
  ['Rvc']    = 'V-REPLACE',
  ['Rvx']    = 'V-REPLACE',
  ['c']      = 'COMMAND',
  ['cv']     = 'EX',
  ['ce']     = 'EX',
  ['r']      = 'REPLACE',
  ['rm']     = 'MORE',
  ['r?']     = 'CONFIRM',
  ['!']      = 'SHELL',
  ['t']      = 'TERMINAL[I]',
  ['nt']     = 'TERMINAL[N]',
  ['ntT']    = 'TERMINAL[N]',
}

---@type table<string, StatuslineModule>
local M = {}

function M.mode()
	local mode_code = vim.api.nvim_get_mode().mode
	if mode_map[mode_code] == nil then
		return mode_code
	end
	return mode_map[mode_code]
end

function M.git()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end

	local added = (git_info.added and git_info.added ~= 0) and ("%#GitSignsAdd# +" .. git_info.added) or ""
	local changed = (git_info.changed and git_info.changed ~= 0) and ("%#GitSignsChange# ~" .. git_info.changed) or ""
	local removed = (git_info.removed and git_info.removed ~= 0) and ("%#GitSignsDelete# -" .. git_info.removed) or ""

	return table.concat({
		" " .. git_info.head,
		added,
		changed,
		removed,
	})
end

local showcmd_filter = { "h", "j", "k", "l", "i", "o" }
function M.showcmd()
	local text = vim.api.nvim_eval_statusline("%S", {}).str or ""
	local state = vim.api.nvim_exec2("echo state()", { output = true }).output

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

M.filename = "%F"

M.lineinfo = "%p%% %l:%c"

return M
