---@type ConfigAutocmd[]
return {
	{ "BufEnter", command = "setlocal formatoptions-=cro" },
	{
		"TextYankPost",
		desc = "Highlight when yanking (copying) text",
		group = vim.api.nvim_create_augroup("custom-highlight-yank", { clear = true }),
		callback = function()
			vim.highlight.on_yank()
		end,
	},
	vim.env.TERM == "xterm-kitty" and {
		"VimEnter",
		once = true,
		callback = function()
			if vim.env.TERM == "xterm-kitty" then
				vim.fn.jobstart("kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0", { detach = true })
				vim.api.nvim_create_user_command("KittyPadding", function()
					vim.fn.jobstart("kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0", { detach = true })
				end, {})
				vim.keymap.set("n", "<M-S-r>", vim.cmd.KittyPadding, { noremap = true, silent = true })
			end
		end,
	} or nil,
	vim.env.TERM == "xterm-kitty" and {
		"VimLeave",
		callback = function()
			if vim.env.TERM == "xterm-kitty" then
				vim.keymap.del("n", "<M-S-r>")
				vim.api.nvim_del_user_command("KittyPadding")
				vim.fn.jobstart("kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=10", { detach = true })
			end
		end,
	} or nil,

	{
		"FileType",
		pattern = { "help", "qf" },
		callback = vim.schedule_wrap(function(ctx)
			vim.keymap.set("n", "q", vim.cmd.quit, { noremap = true, silent = true, buffer = ctx.buf })
		end),
	},
	{
		"TermOpen",
		callback = function()
			vim.opt_local.statuscolumn = ""
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
			vim.cmd.startinsert()
		end,
	},
}
