local M = {}
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "VimEnter" }, {
	once = true,
	pattern = "*",
	command = "set formatoptions-=cro",
})

autocmd("BufRead", {
	callback = function()
		autocmd("BufWinEnter", {
			once = true,
			command = "normal! zx",
		})
	end,
})

autocmd({ "BufWritePost" }, {
	pattern = "xresources",
	command = "silent !xrdb %",
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
	},
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :q!<CR> 
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

autocmd({ "FileType" }, {
	pattern = { "toggleterm" },
	callback = function()
		vim.opt_local.wrap = true
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
		vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
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

M.bullets_enabled_file_types = { "markdown" }

autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		if not vim.tbl_contains(M.bullets_enabled_file_types, vim.bo.filetype) then
			vim.g.bullets_set_mappings = 0
		end
	end,
})

return M
