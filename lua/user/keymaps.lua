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
map("x", "p", "\"_dP")

map("x", "c", "\"_c")
map("x", "d", "\"_d")
map("x", "s", "\"_s")
map("x", "r", "\"_r")

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
map("v", "`", "c`<Esc>pa`<Esc>v2i`")
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
