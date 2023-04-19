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

autocmd("FileType", {
	once = true,
	pattern = { "markdown", "gitcommit" },
	callback = function()
		if vim.bo.filetype == "gitcommit" then
			vim.cmd("setlocal colorcolumn=80")
		elseif vim.bo.filetype == "markdown" then
			vim.cmd("setlocal wrap")
		end
		vim.cmd("setlocal spell")
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
			vim.cmd("silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=10")
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

autocmd({ "VimEnter" }, {
	pattern = "*",
	callback = function()
		if vim.fn.system("pwd"):gsub("\n", ""):sub(1, #(vim.env.HOME .. "/work")) == vim.env.HOME .. "/work" then
      vim.opt.expandtab = true
      vim.opt.colorcolumn = "120"
		end
	end,
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
