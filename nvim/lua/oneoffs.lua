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
vim.g.nvim_tree_tab_open = 1

-- Colorizer
require "colorizer".setup()

-- IndentLine
vim.g.indentLine_char = "▏"
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
  "class",
  "function",
  "method",
  "^if",
  "^while",
  "^for",
  "^object",
  "^table",
  "^case",
  "element",
  "block",
  "arguments"
}
cmd [[ autocmd FileType man execute 'IndentBlanklineDisable' ]]

-- vim.g.indent_blankline_show_current_context = true
-- cmd [[ autocmd FileType markdown let g:indentLine_setConceal = 0 ]]

-- Emmet
vim.g.user_emmet_leader_key = ","

-- cmd [[ let emmet_semicolon = ['html'] ]]

-- cmd [[
-- autocmd BufEnter * if index(emmet_semicolon, &ft) >= 0 | inoremap <silent> ; <Esc>:exec 'norm l'<CR>:call emmet#expandAbbr(3,"")<CR>i
-- ]]

-- Ultisnips
vim.g.UltiSnipsExpandTrigger = "<c-l>"
vim.g.UltiSnipsJumpForwardTrigger = "<c-j>"
vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"

local function trim(s)
   return s:match( "^%s*(.-)%s*$" )
end

_G.show_snippets = function()
	local result = vim.api.nvim_exec([[ echo string(UltiSnips#SnippetsInCurrentScope()) ]], true)
	result = result:gsub("'", ""):gsub("{", ""):gsub("}", "")
	local snips = {}
	for word in string.gmatch(result, '([^,]+)') do
		table.insert(snips, trim(word))
	end
	vim.b.snips = snips
	cmd [[ silent cexpr b:snips | copen ]]
end

map("n", "<leader>ls", ":lua show_snippets()<CR>", {noremap = true, silent = true})

-- Markdown

cmd [[ let g:pandoc#syntax#codeblocks#embeds#langs = ["python", "r", "c"] ]]
cmd [[ autocmd BufEnter *.md setf markdown.pandoc ]]
cmd [[ autocmd BufEnter *.rmd setf markdown.pandoc ]]

_G.edit_code_block = function()
	local current_pos = vim.api.nvim_win_get_cursor(0)
	cmd('?```.\\+')
	local start_pos = vim.api.nvim_win_get_cursor(0)
	cmd('/```')
	cmd('noh')
	local end_pos = vim.api.nvim_win_get_cursor(0)
	if current_pos[1] > start_pos[1] and current_pos[1] < end_pos[1] then
		cmd('?```.\\+')
		-- cmd('norm $F`l')
		cmd('norm jV')
		cmd('/```')
		cmd('norm k"cy')
	end
	vim.api.nvim_win_set_cursor(0, current_pos)
end

map("n", "<leader>me", ":lua edit_code_block()<CR>", {noremap = true, silent = true})
