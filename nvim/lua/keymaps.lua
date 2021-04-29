local map = vim.api.nvim_set_keymap
local cmd = vim.api.nvim_command

-- Remap leader
cmd('let mapleader = " "')
cmd('let maplocalleader = " "')

-- General
map("n", "<Esc>", ":noh<CR><ESC>", {noremap=true, silent = true})
map("t", "<Esc>", "<C-\\><C-n>", {noremap=true, silent = true})
map("n", "<leader>d", ":cd %:p:h<cr>:pwd<cr>", {noremap=true, silent = true})
map("v", ">", ">gv", {noremap=true, silent = true})
map("v", "<", "<gv", {noremap=true, silent = true})

-- Clipboard
map("v", "<M-c>", "\"+y", {noremap=true, silent = true})
map("n", "<M-v>", "\"+p", {noremap=true, silent = true})
map("i", "<M-v>", "<Esc>\"+pa", {noremap=true, silent = true})

-- Window Movement
map("n", "<C-l>", "<C-w>l", {noremap=true, silent = true})
map("n", "<C-h>", "<C-w>h", {noremap=true, silent = true})
map("n", "<C-j>", "<C-w>j", {noremap=true, silent = true})
map("n", "<C-k>", "<C-w>k", {noremap=true, silent = true})

-- Packer
local plugins_file = '~/.config/nvim/lua/plugins.lua'

map("n", "<leader>pi", ":luafile " .. plugins_file .. "<CR>:PackerInstall<CR>", {noremap=true, silent = true})
map("n", "<leader>pc", ":luafile " .. plugins_file .. "<CR>:PackerClean<CR>", {noremap=true, silent = true})