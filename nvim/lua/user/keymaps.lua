local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<leader>d", ":cd %:p:h<CR>:pwd<CR>", opts)
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)
keymap("n", "<Tab>", "za", opts)
keymap("n", "$", "$h", opts)

-- Resize with arrows
keymap("n", "<C-A-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-A-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-A-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<A-S-k>", "<Plug>(cokeline-focus-next)", opts)
keymap("n", "<A-S-j>", "<Plug>(cokeline-focus-prev)", opts)
keymap("n", "<A-S-l>", "<Plug>(cokeline-switch-next)", opts)
keymap("n", "<A-S-h>", "<Plug>(cokeline-switch-prev)", opts)
keymap("n", "<A-S-f>", "<Plug>(cokeline-pick-focus)", opts)
keymap("n", "<A-S-t>", ":tabnew<CR>", opts)
keymap("n", "<A-S-r>", ":tabnew#<CR>", opts)
keymap("n", "<A-S-x>", ":Bdelete!<CR>", opts)


for i = 1,9 do
  keymap('n', ('<A-S-%s>'):format(i),      ('<Plug>(cokeline-focus-%s)'):format(i),  opts)
  -- keymap('n', ('<Leader>%s'):format(i), ('<Plug>(cokeline-switch-%s)'):format(i), { silent = true })
end

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>", opts)

-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "$", "$h", opts)

-- Surround
keymap("v", "\"", "c\"<Esc>pa\"<Esc>v2i\"", opts)
keymap("v", "'", "c'<Esc>pa'<Esc>v2i'", opts)
keymap("v", "`", "c`<Esc>pa`<Esc>v2i`", opts)
keymap("v", "(", "c(<Esc>pa)<Esc>va(", opts)
keymap("v", "[", "c[<Esc>pa]<Esc>va[", opts)
keymap("v", "{", "c{<Esc>pa}<Esc>va{", opts)
keymap("v", "*", "c*<Esc>pa*<Esc>gvll", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Comments
keymap("n", "<C-/>", "gcc", term_opts)
keymap("v", "<C-/>", "gcgv", term_opts)
