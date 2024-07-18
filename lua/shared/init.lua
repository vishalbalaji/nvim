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
---@field callback? any|(fun(event:ConfigAutocmdCallbackOpts):any|string) optional: Lua function (or Vimscript function name, if string) called when the event(s) is triggered. Lua callback can return a truthy value (not false or nil) to delete the autocommand. Receives one argument, a table with these keys:

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

local function set_opts(target, opts)
	for key, value in pairs(opts) do
		local ok, err = pcall(function()
			target[key] = value
		end)
		if not ok then
			print(err)
		end
	end
end

local function set_cmds(commands)
	for _, cmdopts in ipairs(commands) do
		local name = cmdopts[1] or cmdopts.name
		cmdopts[1] = nil
		cmdopts.name = nil

		local command = cmdopts.command
		cmdopts.command = nil

		local ok, err = pcall(vim.api.nvim_create_user_command, name, command, cmdopts)
		if not ok then
			print(err)
		end
	end
end

local function set_autocmds(autocmds)
	for _, auopts in ipairs(autocmds) do
		local event = auopts[1] or auopts.event
		auopts[1] = nil
		auopts.event = nil

		auopts.group = auopts.group or config_group
		local ok, err = pcall(vim.api.nvim_create_autocmd, event, auopts)
		if not ok then
			print(err)
		end
	end
end

---@param options ConfigSpec
function M.setup(options)
	local opts = options.opts or {}

	local wo = opts.wo or {}
	opts.wo = nil

	local bo = opts.bo or {}
	opts.bo = nil

	local opt = opts.opt or {}
	opts.opt = {}

	pcall(set_opts, vim.opt, opt)
	pcall(set_opts, vim.wo, wo)
	pcall(set_opts, vim.bo, bo)
	pcall(set_cmds, options.commands or {})
	pcall(set_autocmds, options.autocmds or {})
end

return M
