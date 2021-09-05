require("nvim_comment").setup(
  {
    hook = function()
      -- They can do anything here, e.g.:
      require("ts_context_commentstring.internal").update_commentstring()
    end
  }
)
vim.api.nvim_set_keymap("n", "<C-_>", ":CommentToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<C-_>", ":CommentToggle<CR>", {noremap = true, silent = true})
