vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "markdown" then
			vim.opt.foldtext = "v:lua.require('pretty-fold').foldtext.global()"
		end
	end,
})
