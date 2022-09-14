-- Comment
require("user.plugins.mini.comment").setup({
  hooks = {
    pre = function()
---@diagnostic disable-next-line: missing-parameter
      require("ts_context_commentstring.internal").update_commentstring()
    end,
  },
})

-- CursorWord
_G.cursorword_blocklist = function()
---@diagnostic disable-next-line: missing-parameter
  local curword = vim.fn.expand("<cword>")
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  local blocklist = {}
  -- Add any disabling global or filetype-specific logic here
  if filetype == "lua" then
    blocklist = { "local", "require" }
  elseif filetype == "javascript" then
    blocklist = { "import" }
  elseif filetype == "python" then
    blocklist = { "import", "from" }
  elseif filetype == "NvimTree" then
    blocklist = { "", "" }
  end

  vim.b.minicursorword_disable = vim.tbl_contains(blocklist, curword)
end

-- -- Make sure to add this autocommand *before* calling module's `setup()`.
vim.cmd([[au CursorMoved * lua _G.cursorword_blocklist()]])
vim.api.nvim_set_hl(0, "MiniCursorWord", { bg = "#3f444a" })

require("user.plugins.mini.cursorword").setup({ delay = 300 })

-- Pairs
require("user.plugins.mini.pairs").setup({})
