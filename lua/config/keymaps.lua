-- Commands
vim.api.nvim_create_user_command("Q", "quitall!", {})
vim.api.nvim_create_user_command("E", "w! | e!", {})

-- General Mappings
local function map(mode, key, mapping, opts)
	opts = opts or {}
	if opts.noremap == nil then
		opts.noremap = true
	end
	if opts.silent == nil then
		opts.silent = true
	end
	vim.keymap.set(mode, key, mapping, opts)
end

vim.g.mapleader = " "
map("n", "<C-S-o>", "<Tab>")
map("n", "<Tab>", "za")
map("n", "<Esc>", "<Esc><cmd>noh<CR>")
map("n", "Q", "<nop>")
map("n", "<leader>d", "<cmd>cd %:p:h<CR><cmd>pwd<CR>")
map("n", "<leader>m", vim.cmd.messages)
map("n", "gx", function()
	vim.fn.jobstart({ "xdg-open", vim.fn.expand("<cfile>") })
end)
map("x", "gx", function()
	vim.fn.jobstart({ "xdg-open", vim.fn.expand("<cfile>") })
end)

-- Maintain Cursor Position
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Clipboard Stuff
map("v", "p", '"_dP')
map("v", "d", '"_d')
map("v", "c", '"_c')

map("n", "d", '"_d')
map("n", "c", '"_c')

map("n", "xx", "Vd")
map("n", "x", "d")

map("x", "s", '"_s')
map("x", "r", '"_r')

-- Move
map("n", "<A-h>", "<Plug>GoNSMLeft")
map("n", "<A-j>", "<Plug>GoNSMDown")
map("n", "<A-k>", "<Plug>GoNSMUp")
map("n", "<A-l>", "<Plug>GoNSMRight")
map("x", "<A-h>", "<Plug>GoVSMLeft")
map("x", "<A-j>", "<Plug>GoVSMDown")
map("x", "<A-k>", "<Plug>GoVSMUp")
map("x", "<A-l>", "<Plug>GoVSMRight")
map("v", ">", ">gv")
map("v", "<", "<gv")

-- Surround
-- -- NOTE: Doesn't work with muti-line selections
map("v", '"', '"xc"<Esc>"xpa"<Esc>v2i"')
map("v", "'", "\"xc'<Esc>\"xpa'<Esc>v2i'")
map("v", "(", '"xc(<Esc>"xpa)<Esc>va(')
map("v", "[", '"xc[<Esc>"xpa]<Esc>va[')
map("v", "{", '"xc{<Esc>"xpa}<Esc>va{')
map("v", "*", '"xc*<Esc>"xpa*<Esc>gvll')
map("v", "`", '"xc`<Esc>"xpa`<Esc>v2i`')
-- map("x", "<", "c<<Esc>pa><Esc>va<")

-- Visual Search
local cr_termcode = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
map("v", "/", function()
	vim.opt.lazyredraw = true

	vim.fn.execute('normal! "sy')
	local pattern = vim.inspect(vim.fn.getreg("s"))
	pattern = string.sub(pattern, 2, string.len(pattern) - 1)
	pattern = string.gsub(pattern, "/", "\\/")
	vim.api.nvim_feedkeys("/" .. pattern .. cr_termcode .. "N", "n", false)

	vim.opt.lazyredraw = false
end)

-- Splits and Tabs
map("n", "<C-s>", "<C-w>s")
map("n", "<C-S-s>", "<C-w>v")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<C-S-0>", "<C-w>=")

-- -- Tabs
map("n", "<M-S-t>", "<cmd>enew!<CR>")
map("n", "<M-S-x>", "<cmd>Bdelete!<CR>")
map("n", "<M-S-w>", "<cmd>Bdelete!<CR>")

-- -- Splits
map("n", "<C-w>", "<C-w>q")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-S-0>", "<C-w>=")

map("t", "<C-Space>", "<C-\\><C-n>")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Other
map("n", "<leader>x", "!chmod +x %")

return map
