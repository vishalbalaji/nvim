local M = {
	"folke/noice.nvim",
	enabled = true,
	priority = 998,
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
					border = { style = "rounded" },
					relative = "cursor",
					position = { row = 2 },
				},
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
