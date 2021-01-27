function! coc#source#gh_emoji#init() abort
	return {
				\ 'shortcut': 'Github Emoji',
				\ 'priority': 10,
				\ 'filetypes': ['gitcommit'],
				\ 'triggerCharacters': [':']
				\}
endfunction

function! coc#source#gh_emoji#complete(opt, cb) abort
	let items = [
			\{
			\ 'word': 'arrow_up:',
			\ 'menu':  '⬆ ', 
			\ 'abbr': ':arrow_up:'
			\},
			\{
			\ 'word': 'x:',
			\ 'menu': '❌', 
			\ 'abbr': ':x:'
			\},
			\{
			\ 'word': 'arrow_left:',
			\ 'menu': '⬅ ', 
			\ 'abbr': ':arrow_left:'
			\},
			\{
			\ 'word': 'sparkles:',
			\ 'menu': '✨', 
			\ 'abbr': ':sparkles:'
			\},
			\{
			\ 'word': 'heavy_plus_sign:',
			\ 'menu': '➕', 
			\ 'abbr': ':heavy_plus_sign:'
			\},
			\{
			\ 'word': 'bug:',
			\ 'menu': '🐛', 
			\ 'abbr': ':bug:'
			\}
		\]
	call a:cb(items)
endfunction
