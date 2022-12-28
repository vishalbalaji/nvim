local autocmd = vim.api.nvim_create_autocmd
local kitty_group = vim.api.nvim_create_augroup("kitty_mp", {
	clear = true,
})

autocmd("VimEnter", {
	once = true,
	command = "set formatoptions-=cro",
})

autocmd("FileType", {
	once = true,
	pattern = { "help", "qf" },
	callback = function()
		vim.keymap.set("n", "q", vim.cmd.quit, { noremap = true, silent = true })
	end,
})

autocmd("BufRead", {
	callback = function()
		autocmd("BufWinEnter", {
			once = true,
			command = "normal! zxzR",
		})
	end,
})

autocmd({ "VimEnter" }, {
	once = true,
	pattern = { vim.env.MYVIMRC, "zshrc" },
	command = [[ cd %:p:h ]],
})

autocmd({ "VimEnter" }, {
	once = true,
	pattern = "*",
	group = kitty_group,
	command = [[ silent ![ "$TERM" = "xterm-kitty" ] &&  kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0 ]],
})

autocmd({ "VimLeavePre" }, {
	once = true,
	pattern = "*",
	group = kitty_group,
	command = [[ silent ![ "$TERM" = "xterm-kitty" ] &&  kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=10 ]],
})

autocmd("Filetype", {
	pattern = "python",
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.softtabstop = 2
		vim.opt.shiftwidth = 2
		vim.opt.expandtab = false
	end,
})
