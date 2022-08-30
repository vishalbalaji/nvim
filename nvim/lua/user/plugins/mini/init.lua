require("user.plugins.mini.comment").setup({
  hooks = {
    pre = function()
      require("ts_context_commentstring.internal").update_commentstring()
    end,
  },
})
require("user.plugins.mini.pairs").setup({})

vim.api.nvim_set_hl(0, "MiniCursorWord", { bg = "#3f444a" })
require("user.plugins.mini.cursorword").setup({ delay = 300 })
