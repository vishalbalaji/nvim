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
		for m in b:addresses
			if m.word =~ '.*' . a:base[1:] . '.*'
				call add(res, m)
			endif
		endfor
		return res
	endif
endfun