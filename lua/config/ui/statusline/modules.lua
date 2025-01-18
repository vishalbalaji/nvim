---@type table<string, StatusLineModule|any>
local M = {
	---@type table<string, fun(...):StatusLineModule>
	create = {},
	---@type table<string, fun(...):StatusLineModule>
	util = {},
}

local statusline_group = vim.api.nvim_create_augroup("StatuslineModules", { clear = true })

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

function M.create.diagnostics()
	vim.api.nvim_create_autocmd("DiagnosticChanged", {
		group = statusline_group,
		pattern = "*",
		command = "redrawstatus",
	})

	local s = vim.diagnostic.severity
	local diagnostic_order = { s.HINT, s.INFO, s.WARN, s.ERROR }
	return function()
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
end

function M.create.showcmd()
	vim.opt.showcmdloc = "statusline"
	local showcmd_filter = { "h", "j", "k", "l", "i", "o" }
	return function()
		local text = vim.api.nvim_eval_statusline("%S", {}).str or ""
		local state = vim.fn.state()

		if state == "S" and vim.tbl_contains(showcmd_filter, text) then
			text = ""
		end

		return text
	end
end

function M.macro_recording()
	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	else
		return "| " .. M.util.hl(Config.icons.ui.Circle, "RainbowRed", "Normal") .. " Recording @" .. recording_register .. " |"
	end
end

--Relative path
function M.filename()
	local text = vim.api.nvim_eval_statusline("%{expand('%:~:.')}", {}).str
	return text ~= "" and text or "[No Name]"
end

---@param section string
function M.util.get_mode_hl(section)
	return function()
		local hl_group = "lualine_" .. section .. Config.lualine.get_mode_suffix()
		return vim.fn.hlexists(hl_group) == 1 and hl_group or ""
	end
end

---@param hl_name string
function M.util.hl(text, hl_name, ending)
	ending = ending or "StatusLine"
	return "%#" .. hl_name .. "#" .. text .. "%#" .. ending .. "#"
end

function M.create.lsp()
	local attached_lsp = {}
	vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
		group = statusline_group,
		pattern = "*",
		callback = vim.schedule_wrap(function(data)
			local items = {}
			for _, value in ipairs(vim.lsp.get_clients({ bufnr = data.buf })) do
				table.insert(items, value.name)
			end

			attached_lsp[data.buf] = table.concat(items, " ")
			vim.cmd("redrawstatus")
		end),
	})

	return function()
		local attached = attached_lsp[vim.api.nvim_get_current_buf()] or ""
		if attached == "" then
			return ""
		end
		return "LSP:" .. " " .. attached
	end
end

function M.ft()
	return vim.bo.filetype
end

function M.create.ft_icon()
	local devicons = require("nvim-web-devicons")

	vim.api.nvim_create_autocmd("BufEnter", {
		group = statusline_group,
		pattern = "*",
		callback = function(ctx)
			local icon, hl = devicons.get_icon(vim.fs.basename(ctx.file))
			if not icon then
				icon, hl = devicons.get_icon_by_filetype(vim.bo[ctx.buf].ft)
			end
			_G.stl_ft_icon = icon
			_G.stl_ft_hl = hl
		end,
	})

	return function()
		if not _G.stl_ft_icon then
			return ""
		end
		---@type string
		return M.util.hl(_G.stl_ft_icon, _G.stl_ft_hl)
	end
end

M.lineinfo = "%l:%c %p%%"

return M
