"Colorizer
lua require'colorizer'.setup()

"RainbowParantheses
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

"FZF
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let $FZF_DEFAULT_OPTS = '-i'

map <C-p> :Files<cr>
map <leader>gf :GFiles<cr>

"Fugitive
map <leader>gs :Git<cr>
map <leader>gd :Git diff<cr>
map <leader>gc :Gco<cr>
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
