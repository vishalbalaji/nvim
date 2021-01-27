source ~/.config/nvim/plugins.vim

"Colors

colorscheme gruvbox
hi Folded cterm=BOLD ctermbg=236 guibg=#32302f
hi clear FoldColumn
hi clear SignColumn

"Let 

let &termguicolors = 1
let mapleader=' '
let maplocalleader = ' '

"Set

set nu rnu
set noerrorbells
set list listchars=nbsp:␣,tab:\⏐\ ,extends:›,precedes:‹,trail:·,space:·

set tabstop=2 softtabstop=2
set shiftwidth=2
set noexpandtab
set smartindent

set cursorline
set showtabline=2
set signcolumn=auto
set formatoptions-=cro

set ignorecase smartcase
set splitbelow splitright
set timeoutlen=200
set noswapfile
set nobackup

"Au

autocmd VimResized * if (&columns <= 120) | set nowrap | else | set wrap | endif
augroup remember_folds
	autocmd!
	autocmd BufWinLeave * silent! mkview
	autocmd BufWinEnter * silent! loadview
augroup END

"Commands

try
	command Q qa!
	command W w!
	command Wq wq
	command WQ wq
catch
	echo ""
endtry

"Map

map <M-r> :source $MYVIMRC<cr>:call lightline#update()<cr>:echo "Config reloaded"<cr>
map <leader>d :cd %:p:h<cr>:pwd<cr>
map <leader>pi :PlugInstall<cr>
map <leader>pc :PlugClean<cr>
map <M-S-Right> :bn!<cr>
map <M-S-Left> :bp!<cr>
map <M-S-k> :bn!<cr>
map <M-S-j> :bp!<cr>
map <M-S-x> :bd!<cr>
map <M-S-t> :tabnew!<cr>
map <C-Right> <C-w>l
map <C-Left> <C-w>h
map <C-Up> <C-w>k
map <C-Down> <C-w>j
map <C-l> <C-w>l
map <C-h> <C-w>h
map <C-k> <C-w>k
map <C-j> <C-w>j
map <Tab> za

inoremap <M-v> <Esc>"+pi

map <Esc> <Esc>:noh<cr>
map <M-v> "+p

vmap <M-c> "+y

"Misc

if &columns <= 120
	set nowrap
endif

runtime! ./custom_configs/*.vim
