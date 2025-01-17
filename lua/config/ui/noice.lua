return {
	"folke/noice.nvim",
	event = "LazyFile",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>n", vim.cmd.Noice },
	},
	opts = {
		cmdline = {
			view = "cmdline",
		},
		popupmenu = {
			enabled = false,
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "written",
				},
				opts = { skip = true },
			},
		},
		debug = false,
		presets = {
			cmdline_output_to_split = false,
		},
		lsp = {
			documentation = {
				opts = {
					-- border = { style = "rounded" },
					relative = "cursor",
					position = { row = 2 },
				},
			},
			hover = {
				---@type NoiceViewOptions
				opts = {
					border = { padding = { top = 1, right = 1, bottom = 1, left = 1 } },
				},
			},
		},
	},
	config = function(_, opts)
		require("noice").setup(opts)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function(event)
				vim.schedule(function()
					require("noice.text.markdown").keys(event.buf)
				end)
			end,
		})
	end,
}
