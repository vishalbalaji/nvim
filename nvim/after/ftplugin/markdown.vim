inoremap <silent> ;; <Esc>a<C-e><C-x><C-o>

function! GetCurrentWord()
  let c = col ('.')-1
  let l = line('.')
  let ll = getline(l)
  let ll1 = strpart(ll,0,c)
  let ll1 = matchstr(ll1,'\S*$')
  if strlen(ll1) == 0
    return ll1
  else
    let ll2 = strpart(ll,c,strlen(ll)-c+1)
    let ll2 = strpart(ll2,0,match(ll2,'$\|\s'))
    return ll1.ll2
  endif
endfunction


function! CustomComplete()
	if GetCurrentWord()[0] == '@' && filereadable(b:bib_file)
		let g:test = feedkeys(';;')
	endif
endfu

autocmd TextChangedI * call CustomComplete()

hi Popup ctermbg=239 guibg=#504945 ctermfg=167 guifg=#fb4934

if index(keys(b:), 'bib_file') == -1
	try
		let metadata = split(join(readfile(expand('%')), '\n'), '---')[0]
		let b:bib_file = split(matchstr(metadata, 'bibliography:[^\\n]*'), " ")[1]
	catch
		let b:bib_file = 'refs.bib'
	endtry
endif

let b:references = []

if filereadable(b:bib_file)
	let raw = join(readfile(b:bib_file), "\n")
	let entries = split(raw, "\n\n")

	for entry in entries
		let tag = substitute(split(matchstr(entry, '^@.[^\n]*'), '{')[1], ',', '', 'g')
		let title = substitute(substitute(split(matchstr(entry, 'title\s*=[^\n]*'), '=')[1], '{', '', 'g'), '}', '', 'g')[:-2]
		let item = {'word': tag, 'abbr': '@'.tag, 'info': title, 'kind': '🗎 [BibTex]'}
		call add(b:references, item)
	endfor
endif


let g:float_preview#docked = 0
let g:float_preview#max_width = 80
let g:float_preview#winhl = 'Normal:Normal,NormalNC:Popup'

setlocal iskeyword-=@
setlocal completeopt=menuone,noinsert,noselect
setlocal omnifunc=markdowncomplete#CompleteAddress
