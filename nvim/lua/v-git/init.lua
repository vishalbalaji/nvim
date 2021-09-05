local map = vim.api.nvim_set_keymap
local cmd = vim.api.nvim_command

cmd("autocmd VimEnter * hi! link GitSignsAdd GitGutterAdd")
cmd("autocmd VimEnter * hi! link GitSignsChange GitGutterChange")
cmd("autocmd VimEnter * hi! link GitSignsDelete GitGutterDelete")

require("gitsigns").setup {
  signs = {
    add = {hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn"},
    change = {hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"},
    delete = {hl = "GitSignsDelete", text = "│", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
    topdelete = {hl = "GitSignsDelete", text = "│", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
    changedelete = {hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"}
  }
}

-- Fugitive Mappings

map("n", "<leader>gs", ":Git<CR>", {noremap = true, silent = true})
map("n", "<leader>gd", ":Git diff %<CR>", {noremap = true, silent = true})
map("n", "<leader>gc", ":Git commit<CR>", {noremap = true, silent = true})
map("n", "<leader>gp", ":cd %:p:h<cr>:15Term git push origin HEAD<CR>", {noremap = true, silent = true})
