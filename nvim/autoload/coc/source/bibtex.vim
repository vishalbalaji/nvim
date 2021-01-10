function! coc#source#bibtex#init() abort
	return {
				\ 'priority': 9,
				\ 'shortcut': 'Bibtex',
				\ 'filetypes': ['vimwiki', 'markdown'],
				\ 'triggerCharacters': ['@']
				\}
endfunction

function! coc#source#bibtex#complete(opt, cb) abort
	if filereadable('refs/refs.bib') 
		let raw = readfile('refs/refs.bib')
		let items = []
		for item in raw
			if item[0] == '@'
				call add(items, substitute(split(item, '{')[1], ",", "", "g"))
			endif
		endfor
		call a:cb(items)
	endif
endfunction
