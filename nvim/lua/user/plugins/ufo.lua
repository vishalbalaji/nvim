local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
	return
end

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.keymap.set("n", "zc", function()
	vim.opt.foldlevel = 99
	vim.opt.foldlevelstart = 99
	ufo.closeFoldsWith()
end, {})

vim.keymap.set("n", "zo", function()
	vim.opt.foldlevel = 99
	vim.opt.foldlevelstart = 99
	ufo.openAllFolds()
end, {})

vim.keymap.set("n", "zp", function()
	return ufo.peekFoldedLinesUnderCursor(20, true, true)
end, {})

ufo.setup({
	open_fold_hl_timeout = 0,
	provider_selector = function()
		return { "treesitter", "indent" }
	end,
})
