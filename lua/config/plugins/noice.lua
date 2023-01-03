local M = {
	"folke/noice.nvim",
	enabled = true,
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}

function M.config()
	require("noice").setup({
		cmdline = {
			view = "cmdline",
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
		lsp = {
			hover = {
				enabled = false,
			},
			signature = {
				enabled = false,
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
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = true,
			cmdline_output_to_split = false,
		},
		commands = {
			all = {
				-- options for the message history that you get with `:Noice`
				view = "split",
				opts = { enter = true, format = "details" },
				filter = {},
			},
		},
	})

	vim.keymap.set("n", "<leader>n", vim.cmd.Noice, { desc = "Noice" })

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "markdown",
		callback = function(event)
			vim.schedule(function()
				require("noice.text.markdown").keys(event.buf)
			end)
		end,
	})
end

return M
