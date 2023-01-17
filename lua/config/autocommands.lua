local autocmd = vim.api.nvim_create_autocmd

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

if vim.env.TERM == "xterm-kitty" then
	autocmd({ "VimEnter" }, {
		once = true,
		callback = function()
			vim.cmd("silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0")
		end,
	})

	autocmd({ "VimLeave" }, {
		callback = function()
			vim.cmd("!kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=10")
		end,
	})
end

autocmd({ "Filetype" }, {
	once = true,
	pattern = "gitcommit",
	command = "startinsert",
})

autocmd({ "BufReadPost" }, {
	pattern = "*",
	command = 'silent! normal! g`"zv',
})


-- To enforce tabs instead of spaces in
-- autocmd("Filetype", {
-- 	pattern = { "python", "markdown" },
-- 	callback = function()
-- 		vim.opt.tabstop = 2
-- 		vim.opt.softtabstop = 2
-- 		vim.opt.shiftwidth = 2
-- 		vim.opt.expandtab = false
-- 	end,
-- })
