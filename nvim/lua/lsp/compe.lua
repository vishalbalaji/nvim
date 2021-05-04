local cmd = vim.api.nvim_command

vim.o.completeopt = "menuone,noinsert,noselect"

require "compe".setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,
  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    ultisnips = true,
    tabnine = true,
		emoji = true
  }
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

-- Use c-(j, k) to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<C-j>"
  else
    return vim.fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<C-k>"
  end
end

-- vim.api.nvim_set_keymap("i", "<C-j>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<C-j>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<C-k>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<C-k>", "v:lua.s_tab_complete()", {expr = true})

cmd('inoremap <silent><expr> <C-j>     pumvisible() ? "\\<C-n>" : "\\<C-j>"')
cmd('inoremap <silent><expr> <C-k>     pumvisible() ? "\\<C-p>" : "\\<C-k>"')

cmd('inoremap <silent><expr> <Tab>     pumvisible() ? compe#confirm("<CR>") : "\\<Tab>"')
cmd("inoremap <silent><expr> <C-Space> compe#complete()")
cmd('inoremap <silent><expr> <C-e>     compe#close("<C-e>")')
cmd('inoremap <silent><expr> <C-f>     compe#scroll({ "delta": +4 })')
cmd('inoremap <silent><expr> <C-d>     compe#scroll({ "delta": -4 })')
