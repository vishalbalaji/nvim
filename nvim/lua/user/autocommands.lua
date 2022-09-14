local autocmd = vim.api.nvim_create_autocmd

autocmd("VimEnter", {
	pattern = "*",
	command = "set formatoptions-=cro",
})

autocmd({ "FileType" }, {
	pattern = {
		"Jaq",
		"qf",
		"help",
		"man",
		"lspinfo",
		"spectre_panel",
		"lir",
		"DressingSelect",
		"tsplayground",
		"Markdown",
	},
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      nnoremap <silent> <buffer> <esc> :close<CR> 
      set nobuflisted 
    ]])
	end,
})

autocmd({ "BufEnter" }, {
	pattern = { "term://*" },
	callback = function()
		vim.cmd("startinsert!")
		-- TODO: if java = 2
		vim.cmd("set cmdheight=1")
	end,
})

autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

autocmd({ "VimResized" }, {
	callback = function()
		if vim.api.nvim_win_get_width(0) <= 100 then
			vim.opt.wrap = false
		else
			vim.opt.wrap = true
		end
	end,
})

autocmd({ "CmdWinEnter" }, {
	callback = function()
		vim.cmd("quit")
	end,
})

autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

autocmd({ "CursorHold" }, {
	callback = function()
		local status_ok, luasnip = pcall(require, "luasnip")
		if not status_ok then
			return
		end
		if luasnip.expand_or_jumpable() then
			-- ask maintainer for option to make this silent
			-- luasnip.unlink_current()
			vim.cmd([[silent! lua require("luasnip").unlink_current()]])
		end
	end,
})

autocmd({ "FileType" }, {
	pattern = "markdown",
	callback = function()
		vim.cmd([[ echo 'hello' ]])
		vim.cmd([[ set foldtext=v:lua.require('pretty-fold').foldtext.global()]])
	end,
})
