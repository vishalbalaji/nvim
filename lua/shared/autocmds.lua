---@type ConfigAutocmd[]
return {
	{ "VimEnter", once = true, command = "set formatoptions-=cro" },
	{
		"TextYankPost",
		desc = "Highlight when yanking (copying) text",
		group = vim.api.nvim_create_augroup("custom-highlight-yank", { clear = true }),
		callback = function()
			vim.highlight.on_yank()
		end,
	},
	{
		"FileType",
		once = true,
		pattern = { "help", "qf" },
		callback = vim.schedule_wrap(function(opts)
			print(vim.inspect(opts))
			vim.keymap.set("n", "q", vim.cmd.quit, { noremap = true, silent = true, buffer = opts.buf })
		end),
	},
	{
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
	},
	{
		"VimLeave",
		callback = function()
			if vim.env.TERM == "xterm-kitty" then
				vim.keymap.del("n", "<M-S-r>")
				vim.api.nvim_del_user_command("KittyPadding")
				vim.fn.jobstart("kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=10", { detach = true })
			end
		end,
	},
	{
		"FileType",
		once = true,
		pattern = "markdown",
		callback = function()
			vim.bo.expandtab = true
			vim.bo.tabstop = 2
			vim.bo.softtabstop = 2
			vim.bo.shiftwidth = 2
		end,
	},
	{
		"FileType",
		once = true,
		pattern = { "markdown", "gitcommit", "diff" },
		callback = function()
			if vim.bo.filetype == "diff" then
				vim.cmd("TSBufDisable highlight")
				vim.cmd("hi! link diffAdded DiffAdd")
				return
			end
			if vim.bo.filetype == "gitcommit" then
				vim.cmd("setlocal colorcolumn=80")
			elseif vim.bo.filetype == "markdown" then
				vim.cmd("setlocal wrap")
			end
			vim.cmd("setlocal spell")
		end,
	},
}
