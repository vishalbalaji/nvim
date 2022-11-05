local status_ok, noice = pcall(require, "noice")
if not status_ok then
	return
end

local config = {}

config.cmdline = { view = "cmdline" }

config.popupmenu = { enabled = true, backend = "cmp" }

config.views = {
	mini = {
		size = {
			width = "auto",
			height = "auto",
			max_height = 10,
			max_width = 120,
		},
		border = {
			style = "rounded",
		},
		win_options = {
			winblend = 0,
		},
		position = {
			row = "97%",
			col = "100%",
		},
	},
}

config.lsp = {
	signature = { enabled = true },
	hover = { enabled = false },
	documentation = {
		opts = {
			border = { style = "rounded" },
			relative = "cursor",
			position = {
				row = 2,
			},
			win_options = {
				concealcursor = "n",
				conceallevel = 3,
				winhighlight = {
					Normal = "LspFloat",
					FloatBorder = "LspFloatBorder",
				},
			},
		},
	},
}

config.routes = {
	{
		view = "mini",
		filter = { event = "msg_showmode" },
	},
	{
		filter = {
			event = "msg_show",
			kind = "",
			find = "written",
		},
		opts = { skip = true },
	},
}

noice.setup(config)
