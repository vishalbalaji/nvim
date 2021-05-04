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


function CustomComplete()
	if GetCurrentWord()[0] == '@'
		let g:test = feedkeys(';;')
	endif
endfu

autocmd TextChangedI * call CustomComplete()

hi Popup ctermbg=239 guibg=#504945 ctermfg=167 ctermfg=208 guifg=#fe8019 gui=bold

let g:float_preview#docked = 0
let g:float_preview#max_width = 80
let g:float_preview#winhl = 'Normal:Normal,NormalNC:Popup'

setlocal iskeyword-=@
setlocal completeopt=menuone,noinsert,noselect
setlocal omnifunc=mailcomplete#CompleteAddress
