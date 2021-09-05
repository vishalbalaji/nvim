local cmd = vim.api.nvim_command

-- General
cmd("let &termguicolors = 1")
cmd [[let g:netrw_browsex_viewer = "notify-send '  Opening link...' && setsid -f firefox"]]

cmd("set number rnu")
cmd("set noerrorbells")
cmd [[set list listchars=nbsp:␣,tab:\│\ ,extends:›,precedes:‹,trail:·,space:·]]

cmd("filetype plugin on")
cmd("set autoindent")
cmd("set tabstop=2 softtabstop=2")
cmd("set shiftwidth=2")
cmd("set noexpandtab")

cmd("set guicursor=")
cmd("set cursorline")
cmd("set showtabline=2")
cmd("set signcolumn=auto")
cmd("set formatoptions-=cro")

cmd("set iskeyword-=_")

cmd("set ignorecase smartcase")
cmd("set splitbelow splitright")
cmd("set timeoutlen=200")
cmd("set noswapfile")
cmd("set nobackup")

-- Restore Cursor
cmd [[
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
]]

cmd [[
autocmd BufEnter * try | call ResCur() | catch | echo 'Cannot restore cursor position' | endtry
]]

-- Colorscheme and highlighting
cmd("colorscheme doom-one")

cmd("augroup COLORSCHEME")

cmd("autocmd!")
cmd("autocmd ColorScheme * hi Normal ctermbg=NONE guibg=NONE")
cmd("autocmd ColorScheme * hi EndOfBuffer ctermbg=NONE guibg=NONE")
-- cmd("autocmd ColorScheme * hi LineNr ctermbg=NONE guibg=NONE guifg=#5C6370")

cmd("autocmd ColorScheme * hi Comment cterm=italic gui=italic")
cmd("autocmd ColorScheme * hi clear FoldColumn")
cmd("autocmd ColorScheme * hi clear SignColumn")

---- Tags
cmd("autocmd ColorScheme * hi! YellowBold gui=bold guifg=#ECBE7B")
cmd("autocmd ColorScheme * hi! GreenBold gui=bold guifg=#98C379")
cmd("autocmd ColorScheme * hi! OrangeBold gui=bold guifg=#DA8548")
cmd("autocmd ColorScheme * hi! PurpleBold gui=bold guifg=#C678DD")
cmd("autocmd ColorScheme * hi! BlueBold gui=bold guifg=#51AFEF")

cmd("autocmd ColorScheme * hi! link Todo YellowBold")
cmd("autocmd ColorScheme * hi! link Done GreenBold")
cmd("autocmd ColorScheme * hi! link Credit PurpleBold")

cmd('autocmd VimEnter * call matchadd("Todo", "TODO")')
cmd('autocmd VimEnter * call matchadd("Done", "DONE")')
cmd('autocmd VimEnter * call matchadd("Credit", "CREDIT")')

---- Links/Email IDs
cmd("autocmd ColorScheme * hi! link Link BlueBold")
cmd("autocmd ColorScheme * hi! link EmailId OrangeBold")

cmd [[
autocmd VimEnter * syn match Link "\(https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(in\|uk\|us\|net\|org\|edu\|com\|cc\|br\|jp\|dk\|gs\|de\|xyz\)\(\/[^ ]*\)\?\>"
]]
cmd [[
autocmd VimEnter * syn match EmailId #\v[_=a-z\./+0-9-]+\@[a-z0-9._-]+\a{2}# contains=@NoSpell
]]

cmd("augroup END")

-- Commands
local function define_commands()
  cmd [[
	command Q qa!
	command W w!
	command Wq wq
	command WQ wq
]]
end

if not pcall(define_commands) then
  print("Error")
end
