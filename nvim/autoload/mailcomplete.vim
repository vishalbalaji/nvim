let s:matches = split(system('notmuch address "*"'), "\n")
let s:items = []
for item in s:matches
	try
		let temp = split(item, '<')
		let name = substitute(temp[0], '"', '', 'g')
		let address = split(temp[1], '>')[0]
		call add(s:items, {'word': item, 'abbr': name, 'info': address, 'kind': ' [Mail]'})
	catch 
		call add(s:items, {'word': item, 'info': '', 'kind': ' Mail'})
	endtry
endfor

function! mailcomplete#CompleteAddress(findstart, base)
	" let g:current = substitute(split(string(a:base), ' ')[-1], "'", "", "g")
	if a:findstart
		" locate the start of the word
		exec 'norm F@'
		let start = col('.') - 1
		return start
	else
		" find classes matching "a:base"
		let res = []
		for m in s:items
			if m.word =~ '.*' . a:base[1:] . '.*'
				call add(res, m)
			endif
		endfor
		return res
	endif
endfun
