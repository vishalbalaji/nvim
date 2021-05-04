let s:items = []

if filereadable(b:bib_file)
	let raw = join(readfile(b:bib_file), "\n")
	let entries = split(raw, "\n\n")

	for entry in entries
		let tag = substitute(split(matchstr(entry, '^@.[^\n]*'), '{')[1], ',', '', 'g')
		let title = substitute(substitute(split(matchstr(entry, 'title\s*=[^\n]*'), '=')[1], '{', '', 'g'), '}', '', 'g')[:-2]
		let item = {'word': tag, 'abbr': '@'.tag, 'info': title, 'kind': '🗎 [BibTex]'}
		call add(s:items, item)
	endfor
endif

function! markdowncomplete#CompleteAddress(findstart, base)
	" let g:current = substitute(split(string(a:base), ' ')[-1], "'", "", "g")
	if a:findstart
		" locate the start of the word
		exec 'norm F@'
		let start = col('.')
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
