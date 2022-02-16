vim.cmd [[
try
  colorscheme doom-one
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
hi Comment gui=bold,italic

function! SynGroup()                                                              
  let l:s = synID(line('.'), col('.'), 1)                                         
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')  
endfun
]]
