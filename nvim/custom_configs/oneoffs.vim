"Colorizer
lua require'colorizer'.setup()

"Rainbow
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"Whichkey
autocmd VimEnter * nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
hi WhichKeyFloating ctermfg=223 ctermbg=236 guifg=#ebdbb2 guibg=#32302f

"Move
vmap <expr> <M-l> {'v': "",
			\  'V': ">gv",
			\  '\<c-v>': "",
			\ }[mode()]
vmap <expr> <M-h> {'v': "",
			\  'V': "<gv",
			\  '\<c-v>': "",
			\ }[mode()]

"Telescope

nnoremap <leader>ff <cmd>cd %:p:h<cr><cmd>Telescope find_files<cr>
nnoremap <leader>gf <cmd>cd %:p:h<cr><cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>cd %:p:h<cr><cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"Fugitive
map <leader>gs :Git<cr>
map <leader>gd :Git diff %<cr>
map <leader>gc :Git commit<cr>
map <leader>gp :cd %:p:h<cr>:15Term git push origin HEAD<cr>

"Gitgutter
hi GitGutterChange ctermfg=214 guifg=#fabd2f
hi! link GitGutterChangeDelete GitGutterChange
hi! link GitGutterChangeDeleteInvisible GitGutterChange
hi! link GitGutterChangeDeleteLine GitGutterChange
hi! link GitGutterChangeDeleteLineNr GitGutterChange
hi! link GitGutterChangeInvisible GitGutterChange
hi! link GitGutterChangeLine GitGutterChange
hi! link GitGutterChangeLineNr GitGutterChange

let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '┃'
let g:gitgutter_sign_removed_first_line = '┃'
let g:gitgutter_sign_removed_above_and_below = '┃'

let g:gitgutter_sign_modified_removed = '┃'

"NERD_commenter
map <C-_> <leader>c<space>
vmap <C-_> <leader>c<space>gv

"Undotree
map <leader>u :UndotreeToggle<cr>

if has("persistent_undo")
	set undodir=$HOME/.cache/undotree
	set undofile
endif

"Misc
function! SynGroup(...)
	let l:s = synID(line('.'), col('.'), 1)
	if !a:0
		echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
	endif
	return synIDattr(l:s, 'name')
endfun

fu Indent(direction)
	let current_pos = getpos('.')
	if a:direction == "right"
		norm >>
		let current_pos[2] = current_pos[2]
	elseif a:direction == "left"
		norm <<
		let current_pos[2] = current_pos[2]-2
	endif
	call cursor(current_pos[1], current_pos[2])
	call setpos('.', current_pos)
	call feedkeys('a')
endfu

inoremap <M-l> <Esc>:call Indent("right")<cr>
inoremap <M-h> <Esc>:call Indent("left")<cr>

"Multiple-cursors
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"Mail
autocmd FileType mail hi! link mailURL Link
autocmd FileType mail set textwidth=0 wrapmargin=0
autocmd FileType mail set spell!

"Markdown
autocmd Filetype markdown set ft=markdown.pandoc

"Xresources
autocmd BufWritePost ~/.config/xresources silent !xrdb ~/.config/xresources

"Restore cursor
" Put these in an autocmd group, so that you can revert them with:
" ":augroup vimStartup | au! | augroup END"
augroup vimStartup
	au!

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid, when inside an event handler
	" (happens when dropping a file on gvim) and for a commit message (it's
	" likely a different one than last time).
	autocmd BufReadPost *
		\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
		\ |   exe "normal! g`\""
		\ | endif

augroup END

"CamelCaseMotion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

"Dashboard
"let g:dashboard_custom_header = [
"\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
"\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
"\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
"\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
"\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
"\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
"\]

"let g:dashboard_custom_footer = ['press q to quit']

"let g:dashboard_default_executive = 'telescope'

"nmap <Leader>ss :<C-u>SessionSave<CR>
"nmap <Leader>sl :<C-u>SessionLoad<CR>
"nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
"nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
"nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
"nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
"nnoremap <silent> e :DashboardNewFile<CR>

"let g:dashboard_custom_shortcut={
"\ 'last_session'       : 'SPC s l',
"\ 'find_history'       : 'SPC f h',
"\ 'find_file'          : 'SPC f f',
"\ 'new_file'           : 'e      ',
"\ 'change_colorscheme' : 'SPC t c',
"\ 'find_word'          : 'SPC f a',
"\ 'book_marks'         : 'SPC f b',
"\ }

"autocmd FileType dashboard map <buffer> q :q!<CR>
"autocmd FileType dashboard set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2

"coc-explorer
map <leader>e :CocCommand explorer<CR>

"barbar

let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false

map <M-S-Right> <cmd>BufferNext<cr>
map <M-S-Left> <cmd>BufferPrevious<cr>
map <M-S-k> <cmd>BufferNext<cr>
map <M-S-j> <cmd>BufferPrevious<cr>
map <M-S-h> <cmd>BufferMovePrev<cr>
map <M-S-l> <cmd>BufferMoveNext<cr>

" ALE
let g:ale_virtualtext_cursor = 1

hi! link ALEVirtualTextError GruvboxRed
hi! link ALEVirtualTextStyleError GruvboxRed
hi! link ALEVirtualTextInfo GruvboxAqua
hi! link ALEVirtualTextStyleWarning GruvboxYellowBold
hi! link ALEVirtualTextWarning GruvboxYellow

command ALEReload ALEDisable | ALEEnable
