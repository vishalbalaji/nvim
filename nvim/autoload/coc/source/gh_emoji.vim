function! coc#source#gh_emoji#init() abort
	return {
				\ 'shortcut': 'Github Emoji',
				\ 'priority': 0,
				\ 'filetypes': ['gitcommit'],
				\ 'triggerCharacters': [':']
				\}
endfunction

function! coc#source#gh_emoji#complete(opt, cb) abort
	let raw = readfile('/home/vishal/.cache/gh_emoji')
	let items = []
	for entry in raw
		let parts = split(entry, ' ')
		let emoji = parts[0]
		let name = parts[-1]
		let item = {'word': name.':', 'menu': emoji, 'abbr': ':'.name.':'}
		call add(items, item)
	endfor
	call a:cb(items)
endfunction
