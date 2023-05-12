vim.opt.guicursor = ""
vim.opt.cursorline = true

vim.opt.visualbell = false

vim.opt.laststatus = 3
vim.opt.cmdheight = 0

local ui_icons = require("config.icons").ui
vim.opt.list = true
vim.opt.listchars = {
	lead = ui_icons.MiddleDot,
	trail = ui_icons.MiddleDot,
	tab = ui_icons.LineMiddle .. " ",
}
vim.opt.fillchars = {
	foldopen = ui_icons.ChevronShortDown,
	foldclose = ui_icons.ChevronShortRight,
}

vim.opt.clipboard = "unnamedplus"

vim.opt.nu = true
vim.opt.rnu = true
vim.opt.numberwidth = 9

vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
-- vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
vim.opt.foldcolumn = "1"

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.sidescrolloff = 32
vim.opt.scrolloff = 8

vim.opt.conceallevel = 2

vim.opt.updatetime = 50
