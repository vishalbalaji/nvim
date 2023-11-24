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
	vim.fn.jobstart({ "open", vim.fn.expand("<cfile>") })
end)
map("x", "gx", function()
	vim.fn.jobstart({ "open", vim.fn.expand("<cfile>") })
end)
-- map("n", ":", ":<C-f>")

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
map("n", "s", '"_s')
map("n", "r", '"_r')

map("n", "xx", "Vd")
map("n", "x", "d")

map("x", "s", '"_s')
map("x", "r", '"_r')

-- Move
map("v", ">", "<nop>")

local pattern = [[\v['"({[< (\.\.\.)\@\/\-\_]@<=(\w)|(\.\.\.)|^(\w)|([A-Z])|([]'"\>\)}]\.)@<=(\w)|(['"])@<=([][(){}.,;])(['"])]]
map({'n', 'v'}, 'w', function() vim.fn.search(pattern) end)
map({'n', 'v'}, 'b', function() vim.fn.search(pattern, 'b') end)

-- Surround
local function visual_surround(char)
	return [[:<C-u>lua MiniSurround.add('visual')<CR>]] .. char .. [[gvll]]
end

map("v", '"', visual_surround('"'))
map("v", "'", visual_surround("'"))
map("v", "`", visual_surround("`"))
map("v", "(", visual_surround(")"))
map("v", "[", visual_surround("]"))
map("v", "{", visual_surround("}"))
map("x", "<", visual_surround(">"))
map("v", "*", visual_surround("*"))
map("v", "_", visual_surround("_"))

-- Visual Search
local cr_termcode = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
map("v", "/", function()
	vim.opt.lazyredraw = true

	local special_characters = { "~", "/", "%." }

	vim.fn.execute('normal! "sy')
	local pattern = vim.inspect(vim.fn.getreg("s"))

	pattern = string.sub(pattern, 2, string.len(pattern) - 1)
	for _, char in pairs(special_characters) do
		pattern = string.gsub(pattern, char, "\\" .. char)
	end

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
local wincmd = function(char) return function() vim.cmd.wincmd(char) end end

map("n", "<C-w>", wincmd("q"))
map("n", "<C-j>", wincmd("j"))
map("n", "<C-k>", wincmd("k"))
map("n", "<C-h>", wincmd("h"))
map("n", "<C-l>", wincmd("l"))
map("n", "<C-S-0>", wincmd("="))

local terminal_group = vim.api.nvim_create_augroup("terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	group = terminal_group,
	callback = function()
		map("t", "<C-Space>", "<C-\\><C-n>")
	end,
})

-- Other
map("n", "<leader>x", "!chmod +x %")

return map
