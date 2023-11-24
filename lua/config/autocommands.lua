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
			if vim.env.TERM == "xterm-kitty" then
				vim.fn.jobstart("kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0", { detach = true })
				vim.api.nvim_create_user_command("KittyPadding", function()
					vim.fn.jobstart("kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0", { detach = true })
				end, {})
				vim.keymap.set("n", "<M-S-r>", vim.cmd.KittyPadding, { noremap = true, silent = true })
			end
		end,
	})

	autocmd({ "VimLeave" }, {
		callback = function()
			if vim.env.TERM == "xterm-kitty" then
				vim.keymap.del("n", "<M-S-r>")
				vim.api.nvim_del_user_command("KittyPadding")
				vim.fn.jobstart("kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=10", { detach = true })
			end
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

local function starts_with(str, start)
	return str:sub(1, #start) == start
end

autocmd({ "VimEnter" }, {
	pattern = "*",
	callback = function()
		local current_dir = vim.fn.system("pwd")
		if starts_with(current_dir, vim.env.HOME .. "/work") or starts_with(current_dir, "/media/DATA/work") then
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
