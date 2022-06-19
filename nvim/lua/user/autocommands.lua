vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
    autocmd VimEnter * set fileformat=unix
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
    autocmd FileType markdown setlocal spell
    autocmd FileType markdown setlocal foldmethod=marker
    autocmd BufEnter *.md setlocal syntax=markdown.pandoc
  augroup end

  " let g:pandoc#syntax#codeblocks#embeds#langs = ["python"]
  " let g:pandoc#syntax#conceal#urls = 1

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _xresources
    autocmd!
    autocmd BufWritePost xresources silent !xrdb ~/.config/xresources
  augroup end

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

  " augroup remember_folds
  "   autocmd!
  "   autocmd BufWinLeave * mkview
  "   autocmd BufWinEnter * silent! loadview
  " augroup END

]]

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
