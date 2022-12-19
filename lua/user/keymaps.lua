-- Commands
vim.api.nvim_create_user_command("Q", "quitall!", {})
vim.api.nvim_create_user_command("E", "w! | e!", {})

-- General Mappings
local function map(mode, key, mapping)
	local opts = { noremap = true, silent = true }
	vim.keymap.set(mode, key, mapping, opts)
end

vim.g.mapleader = " "
map("n", "<Tab>", "za")
map("n", "<Esc>", "<Esc><cmd>noh<CR>")
map("n", "Q", "<nop>")
map("n", "<leader>d", "<cmd>cd %:p:h<CR><cmd>pwd<CR>")
map("n", "<leader>m", vim.cmd.messages)

-- Maintain Cursor Position
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Clipboard Stuff
-- -- Function to delete in range, such as di(, da{, etc. without overwriting clipboard
-- -- CREDIT: https://stackoverflow.com/a/72197874
function _G.range_delete(startinsert)
	startinsert = startinsert or false
	local old_func = vim.go.operatorfunc -- backup previous reference
	-- set a globally callable object/function
	_G.op_func_delete = function()
		-- the content covered by the motion is between the [ and ] marks, so get those
		local start = vim.api.nvim_buf_get_mark(0, "[")
		local finish = vim.api.nvim_buf_get_mark(0, "]")

		vim.api.nvim_buf_set_text(0, start[1] - 1, start[2], finish[1] - 1, finish[2] + 1, {})
		if startinsert then
			vim.api.nvim_feedkeys("i", "n", false)
		end

		vim.go.operatorfunc = old_func
		_G.op_func_delete = nil -- deletes itself from global namespace
	end
	vim.go.operatorfunc = "v:lua.op_func_delete"
	vim.api.nvim_feedkeys("g@", "n", false)
end

local function delete_func(key, startinsert)
	startinsert = startinsert or false
	local operator = vim.fn.nr2char(vim.fn.getchar())

	if operator == key then
		vim.api.nvim_feedkeys('"_' .. key .. key, "n", false)
	else
		range_delete(startinsert)
		vim.api.nvim_feedkeys(operator, "n", false)
	end
end

map("v", "p", '"_dP')
map("v", "d", '"_d')
map("v", "c", '"_c')

map("x", "s", '"_s')
map("x", "r", '"_r')

map("n", "xx", "Vd")

map("n", "d", function()
	delete_func("d")
end)
map("n", "c", function()
	delete_func("c", true)
end)

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
map("v", '"', 'c"<Esc>pa"<Esc>v2i"')
map("v", "'", "c'<Esc>pa'<Esc>v2i'")
-- map("v", "`", "c`<Esc>pa`<Esc>v2i`")
map("v", "(", "c(<Esc>pa)<Esc>va(")
map("v", "[", "c[<Esc>pa]<Esc>va[")
map("v", "{", "c{<Esc>pa}<Esc>va{")
map("v", "*", "c*<Esc>pa*<Esc>gvll")
-- map("x", "<", "c<<Esc>pa><Esc>va<")

-- Splits and Tabs
local smart_splits = require("smart-splits")

map("n", "<C-s>", "<C-w>s")
map("n", "<C-S-s>", "<C-w>v")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<C-S-h>", smart_splits.resize_left)
map("n", "<C-S-l>", smart_splits.resize_right)
map("n", "<C-S-k>", smart_splits.resize_up)
map("n", "<C-S-j>", smart_splits.resize_down)
map("n", "<C-S-0>", "<C-w>=")

-- -- Tabs
map("n", "<M-S-t>", "<cmd>tabnew<CR>")
map("n", "<M-S-x>", "<cmd>bdelete!<CR>")
map("n", "<M-S-k>", "<Plug>(cokeline-focus-next)")
map("n", "<M-S-j>", "<Plug>(cokeline-focus-prev)")
map("n", "<M-S-l>", "<Plug>(cokeline-switch-next)")
map("n", "<M-S-h>", "<Plug>(cokeline-switch-prev)")

-- -- Splits
map("n", "<C-q>", "<C-w>q")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-S-0>", "<C-w>=")
map("n", "<C-S-h>", smart_splits.resize_left)
map("n", "<C-S-l>", smart_splits.resize_right)
map("n", "<C-S-k>", smart_splits.resize_up)
map("n", "<C-S-j>", smart_splits.resize_down)

-- Other
map("n", "<leader>x", "!chmod +x %")
