local function append_table(t1, t2)
	for i = 1, #t2 do
		t1[#t1 + 1] = t2[i]
	end
	return t1
end

return {
	name = "config",
	dir = "config.init",
	virtual = true,
	lazy = false,
	priority = 999,

	keys = function()
		---@type ConfigKey[]
		local keys = {}

		return append_table(require("shared.keymaps"), keys)
	end,

	autocmds = function()
		---@type ConfigAutocmd[]
		local autocmds = {}

		return append_table(require("shared.autocmds"), autocmds)
	end,

	---@type ConfigCommands[]
	commands = {
		{ "Q", command = "quitall!" },
		{ "E", command = "e!" },
		{ "W", command = "w! | e!" },
	},

	opts = function()
		---@type ConfigOpts
		local opts = {
			opt = {
				list = true,
				listchars = {
					lead = Config.icons.ui.MiddleDot,
					trail = Config.icons.ui.MiddleDot,
					tab = Config.icons.ui.LineMiddle .. " ",
					nbsp = Config.icons.ui.Nbsp,
				},

				fillchars = {
					foldopen = Config.icons.ui.ChevronShortDown,
					foldclose = Config.icons.ui.ChevronShortRight,
				},
			},
		}

		return vim.tbl_deep_extend("force", require("shared.opts"), opts)
	end,

	config = function(spec, opts)
		require("shared").setup({
			opts = opts,
			autocmds = type(spec.autocmds) == "function" and spec.autocmds() or spec.autocmds,
			commands = type(spec.commands) == "function" and spec.commands() or spec.commands,
		})
	end,
}
