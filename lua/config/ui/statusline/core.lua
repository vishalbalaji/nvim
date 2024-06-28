---@class StatuslineOpts
---@field hl? string

---@alias StatuslineModule string|fun():string

---@class StatuslineComponent: StatuslineOpts
---@field [1] StatuslineModule

---@alias StatuslineGroup (string|(fun():string)|StatuslineComponent)[]

---@class StatuslineGroups
---@field left? StatuslineGroup
---@field middle? StatuslineGroup
---@field right? StatuslineGroup

---@class StatuslineConfig
---@field fillchar? string
---@field groups? StatuslineGroups

---@param group StatuslineGroup
local function process_groups(group)
	if not group then
		return ""
	end

	local items = ""
	local modules = 0

	for _, module in ipairs(group) do
		local t = type(module)
		assert(t == "string" or t == "function" or t == "table", "Invalid statusline module: " .. tostring(group))

		local text = ""
		local opts = {}

		if t == "function" then
			text = module()
		elseif t == "string" then
			text = module
		else
			opts = module
			local f = opts[1]
			if type(f) == "function" then
				f = f()
			end
			text = f
		end

		if text and text ~= "" then
			local hl = opts.hl or "Normal"
			text = table.concat({ "%#", hl, "#", text, "%#StatusLine#" })
			items = items .. (modules > 0 and " " or "") .. text
			modules = modules + 1
		end
	end

	return items
end

local M = {}

---@param opts StatuslineConfig
function M.setup(opts)
	vim.opt.showcmdloc = "statusline"

	Config.hl("StatusLine", { link = "NonText" })
	Config.hl("StatusLineNC", { link = "Statusline" })
	if opts.fillchar and opts.fillchar ~= "" then
		vim.opt.fillchars:append("stl:" .. opts.fillchar)
	end

	Statusline = {}

	Statusline.active = function()
		local groups = opts.groups or {}

		local parts = {}

		local left = process_groups(groups.left)
		if left then
			table.insert(parts, " ")
			table.insert(parts, left)
			table.insert(parts, " ")
		end

		local middle = process_groups(groups.middle)
		if middle then
			table.insert(parts, "%= ")
			table.insert(parts, middle)
			table.insert(parts, " %=")
		end

		local right = process_groups(groups.right)
		if right then
			table.insert(parts, " ")
			table.insert(parts, right)
			table.insert(parts, " ")
		end

		return table.concat(parts)
	end

	function Statusline.inactive()
		return " %F "
	end

	function Statusline.short()
		return " short "
	end

	local statusline_group = vim.api.nvim_create_augroup("Statusline", { clear = true })
	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		group = statusline_group,
		pattern = "*",
		callback = function()
			vim.opt_local.statusline = "%!v:lua.Statusline.active()"
		end,
	})

	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
		group = statusline_group,
		pattern = "*",
		callback = function()
			vim.opt_local.statusline = "%!v:lua.Statusline.inactive()"
		end,
	})

	-- vim.api.nvim_exec2(
	-- 	[[
	-- 			augroup Statusline
	-- 			au!
	-- 			au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
	-- 			au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
	-- 			augroup END
	-- 		]],
	-- 	{ output = false }
	-- )
end

return M
