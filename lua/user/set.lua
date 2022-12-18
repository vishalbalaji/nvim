vim.opt.guicursor = ""
vim.opt.cursorline = true

vim.opt.showmode = false
vim.opt.laststatus = 3

vim.opt.list = true
vim.opt.listchars = "trail:·,tab:│ "

vim.opt.clipboard = "unnamedplus"

vim.opt.nu = true
vim.opt.rnu = true

vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.smartindent = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes:2"

vim.opt.updatetime = 50
