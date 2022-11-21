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
			max_width = 100,
		},
		border = {
			style = "rounded",
		},
		win_options = {
			winblend = 30,
		},
		position = {
			row = "97%",
			col = "100%",
		},
	},
}

config.lsp = {
	hover = {
		enabled = true,
	},
	signature = {
		enabled = true,
	},
	message = {
		enabled = true,
	},
	override = {
		["vim.lsp.util.convert_input_to_markdown_lines"] = true,
		["vim.lsp.util.stylize_markdown"] = true,
		["cmp.entry.get_documentation"] = true,
	},
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

config.markdown = {
	hover = {
		["|(%S-)|"] = vim.cmd.help, -- vim help links
		["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
	},
	highlights = {
		["|%S-|"] = "@text.reference",
		["@%S+"] = "@parameter",
		["^%s*(Parameters:)"] = "@text.title",
		["^%s*(Return:)"] = "@text.title",
		["^%s*(See also:)"] = "@text.title",
		["{%S-}"] = "@parameter",
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
