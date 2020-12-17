augroup vimWiki
	autocmd FileType vimwiki hi! link VimwikiListTodo GruvboxPurpleBold
	autocmd FileType vimwiki hi! link VimwikiHeaderChar GruvboxOrange
	autocmd FileType vimwiki hi! link VimwikiHeader1 GruvboxYellowBold
	autocmd FileType vimwiki hi! link VimwikiHeader2 GruvboxRedBold
	autocmd FileType vimwiki hi! link VimwikiHeader3 GruvboxGreenBold
	autocmd FileType vimwiki hi! link VimwikiHeader4 GruvboxAquaBold
	autocmd FileType vimwiki hi! link VimwikiHeader5 GruvboxPurpleBold
	autocmd FileType vimwiki hi! link VimwikiHeader6 GruvboxBlueBold
	autocmd FileType vimwiki hi! link VimwikiCellSeparator GruvboxYellow
	autocmd FileType vimwiki hi! link VimwikiBoldChar Bold
	autocmd FileType vimwiki hi VimwikiImage ctermfg=208 guifg=#fe8019 cterm=underline
	autocmd FileType vimwiki map <M-cr> :call FollowLink()<cr>
	autocmd FileType vimwiki map <M-]> ]\|
	autocmd FileType vimwiki map <M-[> [\|
	autocmd FileType vimwiki map <leader><leader> :call vimwiki#base#find_next_link()<cr>
	autocmd FileType vimwiki map <leader><Tab> :call vimwiki#base#find_prev_link()<cr>
augroup END

fun FollowLink()
	let group = SynGroup(0)
	if group == "VimwikiWeblink1" || group == "VimwikiWeblink1T"
		let link_regex = "\\(https\\?:\\/\\/\\(\\w\\+\\(:\\w\\+\\)\\?@\\)\\?\\)\\?\\([A-Za-z][-_0-9A-Za-z]*\\.\\)\\{1,}\\(in\\|uk\\|us\\|net\\|org\\|edu\\|com\\|cc\\|br\\|jp\\|dk\\|gs\\|de\\|xyz\\)\\(\\/[^ ]*\\)\\?\\>"
		if getline('.')[col('.')-1] != "["
			norm F[
		endif
		norm vf)y
		let line = @"
		let link = split(split(line, '](')[-1], ')')[0]
		try
			let name = split(split(line, '](')[0], '[')[-1]
		catch
			let name = link
		endtry
		if link =~# link_regex
			exec "silent !notify-send '  Opening ".link."' && setsid -f $BROWSER --new-tab '".link."'"
		else
			if link[0] == "#"
				set nowrapscan
				let pos = getpos('.')
				try
					let tag = substitute(split(link, "#")[0], "\\\\-", "<dash>", "g")
					let tag = substitute(tag, "-", " ", "g")
					let tag = substitute(tag, "[", "\\\\[", "g")
					let tag = substitute(tag, "]", "\\\\]", "g")
					let tag = substitute(tag, "<dash>", "-", "g")
					norm gg
					set ic
					exec "/# ".tag
					set noic
					noh
				catch
					echo "Link not found: '".tag."'"
					call cursor(pos[1], pos[2])
				endtry
				set wrapscan
			else
				cd %:p:h
				try
					let tag = split(link, "#")[1]
				catch
					let tag = ""
				endtry
				let link = split(link, "#")[0]
				if len(split(link, '\.')) <= 1
					if !filereadable(link)
						let link = link.'.md'
					endif
				endif
				try
					let mime = split(execute("silent !mimetype -b ".link), "\n")[-1]
				catch
					let mime = ""
				endtry
				if tag == ""
					if mime =~# "text/" || mime == "application/x-shellscript"
						exec "tabnew ".link
						call lightline#update()
						silent! loadview
						if !filereadable(link) && split(link, '\.')[-1] == "md"
							exec "norm i# ".name
							norm o
							norm o
						endif
					else
						let exists = execute("silent ![ -f '".link."' ] && echo 'yes' || echo 'no'")
						let exists = split(exists, "\n")[-1]
						let new_link = substitute(link, " ", "\\\\ ", "g")
						if exists == "yes"
							exec ("silent !notify-send '  Opening \"".link."\" with xdg-open' && setsid -f xdg-open ".new_link)
						else
							echo "File not found: '".link."'"
						endif
					endif
				else
					if filereadable(link)
						if split(link, '\.')[-1] == "md"
							set nowrapscan
							try
								exec "tabnew ".link
								call lightline#update()
								silent! loadview
								norm gg
								let tag = substitute(tag, "\\\\-", "<dash>", "g")
								let tag = substitute(tag, "-", " ", "g")
								let tag = substitute(tag, "[", "\\\\[", "g")
								let tag = substitute(tag, "]", "\\\\]", "g")
								let tag = substitute(tag, "<dash>", "-", "g")
								set ic
								exec "/# ".tag
								set noic
								noh
							catch
								echo "Link not found: '".tag."'"
							endtry
							set wrapscan
						else
							echo "Can only link within Markdown files!"
						endif
					else
						echo "File does not exist!"
					endif
				endif
				cd %:p:h
			endif
		endif
	elseif group == "VimwikiTag"
		norm yiW
		let tag = substitute(@", ":", "", "g")
		if tag == "TODO"
			let tag = "DONE"
		elseif tag == "DONE"
			let tag = "TODO"
		endif
		echo tag
		norm diW
		exec "norm i:".tag.":"
	else
		echo "No link to follow!"
	endif
endf

