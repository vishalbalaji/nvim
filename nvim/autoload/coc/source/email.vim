function! coc#source#email#init() abort
	return {
				\ 'priority': 11,
				\ 'shortcut': 'Email',
				\ 'filetypes': ['mail', 'markdown'],
				\}
endfunction

function! coc#source#email#complete(opt, cb) abort
	let raw = split(system('notmuch address "*"'), "\n")
	let items = []
	for item in raw
		try
			let temp = split(item, '<')
			let name = temp[0]
			let address = split(temp[1], '>')[0]
			call add(items, {'word': item, 'abbr': name, 'info': address})
		catch 
			call add(items, {'word': item})
		endtry
	endfor
	call a:cb(items)
endfunction
