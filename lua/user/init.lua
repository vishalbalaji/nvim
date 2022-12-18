require("user.keymaps")
require("user.plugins")
require("user.set")
require("user.treesitter")

-- Autocommands
local autocmd = vim.api.nvim_create_autocmd
local kitty_group = vim.api.nvim_create_augroup("kitty_mp", {
	clear = true,
})

autocmd("FileType", {
	once = true,
	pattern = { "help", "qf" },
	command = [[ map q :quit<CR> ]],
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
