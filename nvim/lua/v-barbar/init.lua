local cmd = vim.api.nvim_command

cmd [[let bufferline = get(g:, 'bufferline', {})]]
cmd [[let bufferline.animation = v:false]]

vim.api.nvim_set_keymap('n', '<M-S-k>', ':BufferNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-S-j>', ':BufferPrevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-S-l>', ':BufferMoveNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-S-h>', ':BufferMovePrevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-S-x>', ':BufferClose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-S-t>', ':enew<CR>', { noremap = true, silent = true })
