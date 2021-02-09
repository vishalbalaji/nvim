syn match Link "\(https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(in\|uk\|us\|net\|org\|edu\|com\|cc\|br\|jp\|dk\|gs\|de\|xyz\)\(\/[^ ]*\)\?\>"
syn match EmailId #\v[_=a-z\./+0-9-]+\@[a-z0-9._-]+\a{2}# contains=@NoSpell

autocmd VimEnter,BufEnter,BufWinEnter * call matchadd('Todo', 'TODO:')
autocmd VimEnter,BufEnter,BufWinEnter * call matchadd('Done', 'DONE:')
autocmd VimEnter,BufEnter,BufWinEnter * call matchadd('Credit', 'CREDIT:')

hi Link cterm=UNDERLINE ctermfg=blue guifg=#83a598 gui=underline
hi! link EmailId Special

hi Todo ctermbg=NONE ctermfg=yellow guibg=NONE guifg=#fabd2f cterm=bold gui=bold
hi Done ctermbg=NONE ctermfg=green guibg=NONE guifg=#b8bb26 cterm=bold gui=bold
hi Credit ctermbg=NONE ctermfg=white guibg=NONE guifg=#ebdbb2 cterm=bold gui=bold

hi! GruvboxYellowSign ctermbg=NONE guibg=NONE
hi! GruvboxAquaSign ctermbg=NONE guibg=NONE
hi! GruvboxBlueSign ctermbg=NONE guibg=NONE
hi! GruvboxGreenSign ctermbg=NONE guibg=NONE
hi! GruvboxOrangeSign ctermbg=NONE guibg=NONE
hi! GruvboxPurpleSign ctermbg=NONE guibg=NONE
hi! GruvboxRedSign ctermbg=NONE guibg=NONE
hi! GruvboxYellowSign ctermbg=NONE guibg=NONE
