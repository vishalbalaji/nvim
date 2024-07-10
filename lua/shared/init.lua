---@class ConfigAutocmdCallbackOpts
---@field id (number) autocommand id
---@field event (string) name of the triggered event autocmd-events
---@field group (number|nil) autocommand group id, if any
---@field match (string) expanded value of <amatch>
---@field buf (number) expanded value of <abuf>
---@field file (string) expanded value of <afile>
---@field data (any) arbitrary data passed from nvim_exec_autocmds()

---@class ConfigAutocmd: vim.api.keyset.create_autocmd
---@field [1]? (string|string[]) Event(s) that will trigger the handler
---@field event? (string|string[]) Event(s) that will trigger the handler
---@field callback? any|(fun(opts:ConfigAutocmdCallbackOpts):any|string) optional: Lua function (or Vimscript function name, if string) called when the event(s) is triggered. Lua callback can return a truthy value (not false or nil) to delete the autocommand. Receives one argument, a table with these keys:

---@class ConfigCommands: vim.api.keyset.user_command
---@field [1]? string Name of the new user command. Must begin with an uppercase letter
---@field name? string Name of the new user command. Must begin with an uppercase letter
---@field [2]? string
---@field command? string

---@alias ConfigKey LazyKeysSpec

---@class ConfigSpec
---@field opts? ConfigOpts
---@field autocmds? ConfigAutocmd[]
---@field commands? ConfigCommands[]

local M = {}

local config_group = vim.api.nvim_create_augroup("ConfigGroup", { clear = true })

---@param options ConfigSpec
function M.setup(options)
	local opts = options.opts or {}

	local wo = opts.wo or {}
	opts.wo = nil

	local bo = opts.bo or {}
	opts.bo = nil

	local opt = opts.opt or {}
	opts.opt = {}

	for key, value in pairs(opt) do
		vim.opt[key] = value
	end

	for key, value in pairs(wo) do
		vim.wo[key] = value
	end

	for key, value in pairs(bo) do
		vim.bo[key] = value
	end

	for i, cmdopts in ipairs(options.commands or {}) do
		local name = cmdopts[1] or cmdopts.name
		cmdopts[1] = nil
		cmdopts.name = nil

		local command = cmdopts.command
		cmdopts.command = nil

		if not name or name == "" then
			print("Could not create command with index: " .. i)
			goto continue
		end

		if not command or command == "" then
			print("Could not create command: " .. name)
			goto continue
		end

		vim.api.nvim_create_user_command(name, command, cmdopts)
		::continue::
	end

	for i, auopts in ipairs(options.autocmds or {}) do
		local event = auopts[1] or auopts.event
		auopts[1] = nil
		auopts.event = nil

		if not event or event == "" then
			print("Could not create autocommand with index: " .. i)
			goto continue
		end

		auopts.group = auopts.group or config_group
		vim.api.nvim_create_autocmd(event, auopts)
		::continue::
	end
end

return M
