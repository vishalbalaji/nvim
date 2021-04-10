-- Lua/requires
local cmd = vim.api.nvim_command

require('statusline')

-- General
cmd('set nu rnu')
cmd('set noerrorbells')

cmd('set tabstop=2 softtabstop=2')
cmd('set shiftwidth=2')
cmd('set noexpandtab')
cmd('set smartindent')
cmd('set cursorline')

cmd('set signcolumn=auto')
cmd('set formatoptions-=cro')

cmd('set iskeyword-=_')

cmd('set ignorecase smartcase')
cmd('set splitbelow splitright')
cmd('set timeoutlen=200')
cmd('set noswapfile')
cmd('set nobackup')

cmd('autocmd VimResized * if (&columns <= 120) | set nowrap | else | set wrap | endif')
cmd('autocmd BufWritePost xresources silent !xrdb %')

-- Commands
function define_commands()
	cmd([[
		command Q qa!
		command W w!
		command Wq wq
		command WQ wq
	]])
end

if not pcall(define_commands) then
	print('')
end

-- Mail 
cmd('autocmd FileType markdown.pandoc.mail source ~/.config/nvim/syntax/mail.vim')

-- Colors
cmd('let &termguicolors=1')
cmd('colorscheme gruvbox')

cmd('augroup colorscheme')

cmd('autocmd!')
cmd('autocmd ColorScheme * hi Normal ctermbg=NONE guibg=NONE')
cmd('autocmd ColorScheme * hi clear FoldColumn')
cmd('autocmd ColorScheme * hi clear SignColumn')

cmd('autocmd ColorScheme * hi! link Todo GruvboxYellowBold')
cmd('autocmd ColorScheme * hi! link Done GruvboxGreenBold')
cmd('autocmd ColorScheme * hi! link Credit GruvboxPurpleBold')
cmd('autocmd ColorScheme * call matchadd("Todo", "TODO:")')
cmd('autocmd ColorScheme * call matchadd("Done", "DONE:")')
cmd('autocmd ColorScheme * call matchadd("Credit", "CREDIT:")')

cmd('autocmd ColorScheme * hi! link Link GruvboxBlueBold')
cmd('autocmd ColorScheme * hi! link EmailId GruvboxOrangeBold')
cmd('autocmd VimEnter * syn match Link "\\(https\\?:\\/\\/\\(\\w\\+\\(:\\w\\+\\)\\?@\\)\\?\\)\\?\\([A-Za-z][-_0-9A-Za-z]*\\.\\)\\{1,}\\(in\\|uk\\|us\\|net\\|org\\|edu\\|com\\|cc\\|br\\|jp\\|dk\\|gs\\|de\\|xyz\\)\\(\\/[^ ]*\\)\\?\\>"')
cmd('autocmd VimEnter * syn match EmailId #\\v[_=a-z\\./+0-9-]+\\@[a-z0-9._-]+\\a{2}# contains=@NoSpell')

cmd('augroup END')

-- File Nav
cmd('let g:nvim_tree_tab_open = 1')

-- Tabline/Statusline
---- BarBar
cmd('set showtabline=2')
cmd('let bufferline = get(g:, "bufferline", {})')
cmd('let bufferline.animation = v:false')

-- NvimComment
require('nvim_comment').setup(
{
	-- Linters prefer comment and line to have a space in between markers
	marker_padding = true,
	-- should comment out empty or whitespace only lines
	comment_empty = false,
	-- Should key mappings be created
	create_mappings = true,
	-- Normal mode mapping left hand side
	line_mapping = "gcc",
	-- Visual/Operator mapping left hand side
	operator_mapping = "gc"
})

-- AutoPairs
cmd('au FileType * let b:AutoPairs = AutoPairsDefine({"<" : ">"})')

-- Colorizer
require'colorizer'.setup()

-- ts-rainbow
require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
  }
}

-- Rainbow Parantheses
cmd('au VimEnter * RainbowParenthesesActivate')
cmd('au VimEnter * RainbowParenthesesLoadBraces')
cmd('au VimEnter * RainbowParenthesesLoadRound')
cmd('au VimEnter * RainbowParenthesesLoadSquare')

-- UndoTree
cmd([[
	if has("persistent_undo")
		set undodir=$HOME/.cache/undotree
		set undofile
	endif
]])

