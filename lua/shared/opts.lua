---@class ConfigOpts
---@field opt? vim.opt
---@field wo? vim.wo
---@field bo? vim.bo

---@type ConfigOpts
return {
	opt = {
		termguicolors = true,

		cmdheight = 0,
		visualbell = false,
		laststatus = 3,
		splitkeep = "screen",

		guicursor = "",
		cursorline = true,
		number = true,
		relativenumber = true,
		mouse = "a",

		foldmethod = "expr",
		foldexpr = "nvim_treesitter#foldexpr()",
		foldenable = false,
		foldcolumn = "1",

		clipboard = "unnamedplus",

		breakindent = true,
		tabstop = 2,
		softtabstop = 2,
		shiftwidth = 2,
		expandtab = false,
		smartindent = true,

		undofile = true,

		ignorecase = true,
		smartcase = true,

		signcolumn = "yes",

		updatetime = 250,
		timeoutlen = 300,

		splitright = true,
		splitbelow = true,

		inccommand = "split",
		hlsearch = true,

		scrolloff = 10,
	},

	wo = {
		wrap = false,
	},
}
