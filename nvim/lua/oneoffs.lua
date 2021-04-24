local map = vim.api.nvim_set_keymap
local cmd = vim.api.nvim_command

-- Move
cmd [[
vmap <expr> <M-l> {'v': "", 'V': ">gv", '\<c-v>': ""}[mode()]
vmap <expr> <M-h> {'v': "", 'V': "<gv", '\<c-v>': ""}[mode()] 
]]

-- Telescope
map("n", "<leader>ff", ":cd %:p:h<CR>:Telescope find_files<CR>", {noremap = true, silent = true})
map("n", "<leader>fg", ":cd %:p:h<CR>:Telescope live_grep<CR>", {noremap = true, silent = true})

-- Whichkey
cmd('autocmd VimEnter * nnoremap <silent> <leader> :WhichKey "<Space>"<CR>')

-- Undotree
map("n", "<leader>u", ":UndotreeToggle<cr>", {noremap = true, silent = true})

cmd [[
  if has("persistent_undo")
    set undodir=$HOME/.cache/undotree
    set undofile
  endif
]]

-- Markdown
cmd("autocmd BufEnter *.md set ft=markdown.pandoc")
cmd("autocmd BufEnter *.md let &spell=1")

-- Xresources
cmd("autocmd BufWritePost ~/.config/xresources silent !xrdb ~/.config/xresources")

-- CamelCaseMotion
map("n", "w", "<Plug>CamelCaseMotion_w", {silent = true})
map("n", "b", "<Plug>CamelCaseMotion_b", {silent = true})
map("n", "e", "<Plug>CamelCaseMotion_e", {silent = true})
map("n", "ge", "<Plug>CamelCaseMotion_ge", {silent = true})

-- Wrap on resize
cmd("autocmd VimResized * if (&columns <= 120) | set nowrap | else | set wrap | endif")

-- Nvimtree
map("n", "<leader>et", ":NvimTreeToggle<CR>", {noremap = true, silent = true})
map("n", "<leader>ef", ":NvimTreeFindFile<CR>", {noremap = true, silent = true})
map("n", "<leader>er", ":NvimTreeRefresh<CR>", {noremap = true, silent = true})

-- Colorizer
require'colorizer'.setup()
