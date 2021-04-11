" General
hi Normal ctermbg=NONE guibg=NONE

" Links/Email IDs
hi! link Link GruvboxBlueBold
hi! link EmailId GruvboxOrangeBold

autocmd VimEnter * syn match Link "\(https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(in\|uk\|us\|net\|org\|edu\|com\|cc\|br\|jp\|dk\|gs\|de\|xyz\)\(\/[^ ]*\)\?\>"
autocmd VimEnter * syn match EmailId #\v[_=a-z\./+0-9-]+\@[a-z0-9._-]+\a{2}# contains=@NoSpell

" Tags
hi! link Todo GruvboxYellowBold
hi! link Done GruvboxGreenBold
hi! link Credit GruvboxPurpleBold

autocmd VimEnter * call matchadd('Todo', 'TODO:')
autocmd VimEnter * call matchadd('Done', 'DONE:')
autocmd VimEnter * call matchadd('Credit', 'CREDIT:')

" Gitgutter
hi! GruvboxYellowSign ctermbg=NONE guibg=NONE
hi! GruvboxAquaSign ctermbg=NONE guibg=NONE
hi! GruvboxBlueSign ctermbg=NONE guibg=NONE
hi! GruvboxGreenSign ctermbg=NONE guibg=NONE
hi! GruvboxOrangeSign ctermbg=NONE guibg=NONE
hi! GruvboxPurpleSign ctermbg=NONE guibg=NONE
hi! GruvboxRedSign ctermbg=NONE guibg=NONE
hi! GruvboxYellowSign ctermbg=NONE guibg=NONE

" Mail
autocmd FileType markdown.pandoc.mail source ~/.config/nvim/custom_configs/syntax/mail.vim
