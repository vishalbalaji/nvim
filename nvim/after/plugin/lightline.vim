" Lightline settings

let g:lightline = {
	\ 'colorscheme': 'gruvbox',
	\ 'tabline': {
	\	'left': [ ['buffers'] ],
	\	'right': [ [ '' ] ]
	\ },
	\ 'component_expand': {
	\	'buffers': 'lightline#bufferline#buffers'
	\ },
	\ 'component_type': {
	\	'buffers': 'tabsel'
	\ },
	\ 'separator': {
	\	'left': '',
	\	'right': ''
	\ },
	\ 'active': {
	\		'right': [[ 'lineinfo' ],
	\		[ 'percent' ],
	\		[ 'gitstatus', 'fileformat', 'fileencoding', 'filetype']]
	\ },
	\'component_function': { 
	\	'gitstatus': 'GitStatus' 
	\ }
\ }

let g:lightline#colorscheme#gruvbox#palette.tabline.middle = [['#928374', '#282828', 244, 235]]
let g:lightline#colorscheme#gruvbox#palette.tabline.tabsel = [['#a89984', '#504945', 246, 239]]

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! GitStatus()
	let [a,m,r] = GitGutterGetHunkSummary()
	let branch = FugitiveHead()
	if branch != ""
		return printf(' ' . branch . ': +%d ~%d -%d', a, m, r)
	else
		return printf("")
	endif
endfunction
