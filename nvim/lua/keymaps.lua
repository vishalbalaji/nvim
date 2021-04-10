-- Lua/requires
local map = vim.api.nvim_set_keymap
local cmd = vim.api.nvim_command

-- Remap Leader
map('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '

-- General
map('n', '<Esc>', ':nohl<CR><Esc>', { noremap = true, silent = true })
map('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })

-- Clipboard
map('v', '<M-c>', '"+y', { noremap = true, silent = true })
map('n', '<M-v>', '"+p', { noremap = true, silent = true })
map('i', '<M-v>', '<Esc>"+pa', { noremap = true, silent = true })

-- Tabs/BarBar
-- map('n', '<M-S-j>', ':bp!<CR>', { noremap = true, silent = true })
-- map('n', '<M-S-k>', ':bn!<CR>', { noremap = true, silent = true })
-- map('n', '<M-S-x>', ':bd!<CR>', { noremap = true, silent = true })
map('n', '<M-S-j>', ':BufferPrevious<CR>', { noremap = true, silent = true })
map('n', '<M-S-k>', ':BufferNext<CR>', { noremap = true, silent = true })
map('n', '<M-S-x>', ':BufferClose<CR>', { noremap = true, silent = true })
map('n', '<M-S-l>', ':BufferMoveNext<CR>', { noremap = true, silent = true })
map('n', '<M-S-h>', ':BufferMovePrevious<CR>', { noremap = true, silent = true })
map('n', '<M-S-t>', ':tabnew<CR>', { noremap = true, silent = true })

-- Plugins/Packer
local plugin_file = '~/.config/nvim/lua/plugins.lua'

map('n', '<Leader>pi', ':luafile ' .. plugin_file .. '<CR>:PackerCompile<CR>:PackerInstall<CR>', { noremap = true, silent = true })
map('n', '<Leader>pc', ':luafile ' .. plugin_file .. '<CR>:PackerClean<CR>', { noremap = true, silent = true })

-- File Nav
---- Telescope
map('n', '<leader>ff', ':cd %:p:h<CR><cmd>Telescope find_files<CR>', { noremap = true, silent = true })
map('n', '<leader>gf', ':Telescope git_files<CR>', { noremap = true, silent = true })
map('n', '<leader>fg', ':cd %:p:h<CR><cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
map('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
map('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })

---- NvimTree
map('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Git
---- Fugitive
map('n', '<Leader>gs', ':Git<CR>', { noremap = true, silent = true })
map('n', '<Leader>gd', ':Git diff %<CR>', { noremap = true, silent = true })
map('n', '<Leader>gc', ':Git commit<CR>', { noremap = true, silent = true })
map('n', '<Leader>gp', ':cd %:p:h<CR>:15Term git push origin HEAD<CR>', { noremap = true, silent = true })
 
-- NvimComment
map('n', '<C-_>', ':CommentToggle<CR>', { noremap = true, silent = true })
map('v', '<C-_>', ':CommentToggle<CR>gv', { noremap = true, silent = true })

-- Move
cmd('vmap <expr> <M-l> {"v": "<Plug>MoveBlockRight", "V": ">gv", "\\<c-v>": "<Plug>MoveBlockRight"}[mode()]')
cmd('vmap <expr> <M-h> {"v": "<Plug>MoveBlockLeft", "V": "<gv", "\\<c-v>": "<Plug>MoveBlockLeft"}[mode()]')

-- WhichKey
map('n', '<leader>', ':WhichKey \'<Space>\'<CR>', { noremap = true, silent = true })

-- UndoTree
map('n', '<leader>u', ':UndotreeToggle<CR>', { noremap = true, silent = true })
