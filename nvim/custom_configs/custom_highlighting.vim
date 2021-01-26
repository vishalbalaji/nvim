syn match Link "\(https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(in\|uk\|us\|net\|org\|edu\|com\|cc\|br\|jp\|dk\|gs\|de\|xyz\)\(\/[^ ]*\)\?\>"
syn match EmailId #\v[_=a-z\./+0-9-]+\@[a-z0-9._-]+\a{2}# contains=@NoSpell

autocmd VimEnter,BufEnter,BufWinEnter * call matchadd('Todo', 'TODO:')
autocmd VimEnter,BufEnter,BufWinEnter * call matchadd('Done', 'DONE:')

hi Link cterm=UNDERLINE ctermfg=blue guifg=#83a598 gui=underline
hi! link EmailId Special

hi Todo ctermbg=yellow ctermfg=235 guibg=#fabd2f guifg=#282828
hi Done ctermbg=green ctermfg=235 guibg=#b8bb26 guifg=#282828

hi! GruvboxYellowSign ctermbg=NONE guibg=NONE
hi! GruvboxAquaSign ctermbg=NONE guibg=NONE
hi! GruvboxBlueSign ctermbg=NONE guibg=NONE
hi! GruvboxGreenSign ctermbg=NONE guibg=NONE
hi! GruvboxOrangeSign ctermbg=NONE guibg=NONE
hi! GruvboxPurpleSign ctermbg=NONE guibg=NONE
hi! GruvboxRedSign ctermbg=NONE guibg=NONE
hi! GruvboxYellowSign ctermbg=NONE guibg=NONE
