-- bootstrap from github
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

vim.g.material_style = "deep ocean"
-- load lazy
require("lazy").setup("config.plugins", {
	ui = {
		border = "rounded",
	},
	defaults = { lazy = true },
	checker = { enabled = true, notify = false },
	install = {
		colorscheme = { "material" },
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	debug = false,
})

vim.keymap.set("n", "<leader>p", vim.cmd.Lazy, { desc = "Lazy" })
