vim.cmd([[

  augroup _colorscheme
    autocmd!
    autocmd VimEnter * syn match Todo "TODO"
    autocmd VimEnter * syn match Done "DONE"
    autocmd VimEnter * syn match Credit "CREDIT"
    autocmd VimEnter * syn match Link "\(https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(in\|uk\|us\|net\|org\|edu\|com\|cc\|br\|jp\|dk\|gs\|de\|xyz\)\(\/[^ ]*\)\?\>"
    autocmd VimEnter * syn match Email #\v[_=a-z\./+0-9-]+\@[a-z0-9._-]+\a{2}# contains=@NoSpell

    autocmd ColorScheme * hi! link Done TextSuccessBold
    autocmd ColorScheme * hi! link Credit TextMutedBold
    autocmd ColorScheme * hi! link Link TextInfoBold
    autocmd ColorScheme * hi! link Email TextSpecialBold
  augroup end

]])
