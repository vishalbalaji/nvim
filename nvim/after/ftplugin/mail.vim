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
	if GetCurrentWord()[0] == '@'
		let g:test = feedkeys(';;')
	endif
endfu

let matches = split(system('notmuch address "*"'), "\n")
let b:addresses = []
for item in matches
	try
		let temp = split(item, '<')
		let name = substitute(temp[0], '"', '', 'g')
		let address = split(temp[1], '>')[0]
		call add(b:addresses, {'word': item, 'abbr': name, 'info': address, 'kind': ' [Mail]'})
	catch 
		call add(b:addresses, {'word': item, 'info': '', 'kind': ' Mail'})
	endtry
endfor


autocmd TextChangedI * call CustomComplete()

hi Popup ctermbg=239 guibg=#504945 ctermfg=167 ctermfg=208 guifg=#fe8019 gui=bold

let g:float_preview#docked = 0
let g:float_preview#max_width = 80
let g:float_preview#winhl = 'Normal:Normal,NormalNC:Popup'
let &spell=1

setlocal iskeyword-=@
setlocal completeopt=menuone,noinsert,noselect
setlocal omnifunc=mailcomplete#CompleteAddress
setlocal textwidth=0 wrapmargin=0

autocmd FileType markdown.pandoc.mail source ~/.config/nvim/syntax/mail.vim
