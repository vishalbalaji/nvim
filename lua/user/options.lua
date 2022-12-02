local options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 2, -- more space in the neovim command line for displaying messages
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	concealcursor = "", -- for concealing in markdown and org files
	conceallevel = 2, -- so that `` is visible in markdown files
	cursorline = true, -- highlight the current line
	expandtab = false, -- convert tabs to spaces
	fileencoding = "utf-8", -- the encoding written to a file
	foldexpr = "nvim_treesitter#foldexpr()",
	foldlevel = 9999,
	foldmethod = "expr",
	guicursor = "n-v-c-i:block",
	guifont = "JetBrainsMono Nerd Font:h12", -- the font used in graphical neovim applications
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	laststatus = 3,
	linebreak = true,
	list = true,
	listchars = "eol:↲,trail:·,tab:» ,extends:>,precedes:<",
	mouse = "a", -- allow the mouse to be used in neovim
	number = true, -- set numbered lines
	numberwidth = 4, -- set number column width to 2 {default 4}
	pumheight = 10, -- pop up menu height
	relativenumber = true, -- set relative numbered lines
	scrolloff = 8, -- is one of my fav
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 2, -- always show tabs
	sidescrolloff = 8,
	signcolumn = "yes:2", -- always show the sign column, otherwise it would shift the text each time
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	tabstop = 2, -- insert 2 spaces for a tab
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	winbar = "", -- always show tabs
	wrap = true, -- display lines as one long line
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

vim.g.markdown_fenced_languages = { "python", "javascript", "sh", "yaml", "json" }

-- Firenvim stuff
if vim.g.started_by_firenvim then
	vim.opt.showtabline = 0
	vim.opt.cmdheight = 0
  vim.opt.statusline='[%{toupper(mode())}]%=%m%y'
end

vim.g.firenvim_config = {
	localSettings = {
		[".*"] = { cmdline = "neovim", takeover = "never" },
		-- ["https://[^/]*github\\.com/.*"] = { cmdline = "neovim", priority = 1, takeover = "always" },
	},
}
