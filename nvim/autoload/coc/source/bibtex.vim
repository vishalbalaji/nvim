function! coc#source#bibtex#init() abort
	return {
				\ 'priority': 0,
				\ 'shortcut': 'Bibtex',
				\ 'filetypes': ['vimwiki', 'markdown', 'markdown.pandoc'],
				\ 'triggerCharacters': ['@']
				\}
endfunction

function! coc#source#bibtex#complete(opt, cb) abort
	try
		let metadata = split(join(readfile(expand('%')), '\n'), '---')[0]
		let file = split(matchstr(metadata, 'bibliography:[^\\n]*'), " ")[1]
	catch
		let g:error = 1
		"let file = g:ref_file
	endtry
	if filereadable(file) 
		let raw = join(readfile(file), "\n")
		let entries = split(raw, "\n\n")
		let items = []
		for entry in entries
			let tag = substitute(split(matchstr(entry, '^@.[^\n]*'), '{')[1], ',', '', 'g')
			let title = substitute(substitute(split(matchstr(entry, 'title\s*=[^\n]*'), '=')[1], '{', '', 'g'), '}', '', 'g')[:-2]
			let item = {'word': tag, 'abbr': '@'.tag, 'info': title}
			call add(items, item)
		endfor
		call a:cb(items)
	endif
endfunction
