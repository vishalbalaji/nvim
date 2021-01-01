"         _                                              
"  __   _(_)_ __ ___  _ __ ___                           
"  \ \ / / | '_ ` _ \| '__/ __|  Vishal Balaji D         
"   \ V /| | | | | | | | | (__    vishalbalaji@gmail.com 
"    \_/ |_|_| |_| |_|_|  \___|                          
"                                                        

" Plugins

call plug#begin()

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'junegunn/limelight.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/rainbow_parentheses.vim'
Plug 'markonm/traces.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'habamax/vim-sendtoterm'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'iamcco/markdown-preview.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'matze/vim-move'
Plug 'unblevable/quick-scope'
Plug 'junegunn/vim-easy-align'
Plug 'dag/vim-fish'
Plug 'junegunn/goyo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'gabrielelana/vim-markdown'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'jrudess/vim-foldtext'
Plug 'dkarter/bullets.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vimlab/split-term.vim'
Plug 'vimwiki/vimwiki'
Plug 'Honza/vim-snippets'
Plug 'alx741/vim-hindent'
Plug 'kovetskiy/sxhkd-vim'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'lervag/vimtex'
Plug 'adborden/vim-notmuch-address'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
Plug 'mbbill/undotree'

call plug#end()

" Let

let mapleader=" "
let maplocalleader = " "
let $FZF_DEFAULT_OPTS = '--reverse -i'
let g:netrw_browsex_viewer = "notify-send '  Opening link...' && setsid -f firefox"
let g:vimwiki_table_mappings = 0
let g:markdown_enable_insert_mode_mappings = 0
let g:hindent_on_save = 1
let &termguicolors=1
let g:tex_flavor='latex'
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '┃'
let g:gitgutter_sign_removed_first_line = '┃'
let g:gitgutter_sign_removed_above_and_below = '┃'
let g:gitgutter_sign_modified_removed = '┃'

" Au

"au VimEnter * ColorHighlight
lua require'colorizer'.setup()
au VimEnter * RainbowParenthesesToggle
autocmd VimResized * if (&columns <= 120) | set nowrap | else | set wrap | endif
autocmd FileType * set signcolumn=auto
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au BufWritePost ~/.config/xresources silent !xrdb %
autocmd BufWritePost ~/.config/dwm/dwmblocks/config.h !cd ~/.config/dwm/dwmblocks/; SUDO_ASKPASS=~dpass sudo -A make install && { killall -q dwmblocks;setsid dwmblocks & }
augroup AutoSaveFolds
	autocmd!
	" view files are about 500 bytes
	" bufleave but not bufwinleave captures closing 2nd tab
	" nested is needed by bufwrite* (if triggered via other autocmd)
	autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
	autocmd BufWinEnter,BufEnter ?* silent! loadview | call lightline#update()
augroup end
autocmd VimEnter,BufEnter,BufWinEnter * if &filetype == "vimwiki" | call matchadd('Todo', ':TODO:') | else | call matchadd('Todo', 'TODO:') | endif |
autocmd VimEnter,BufEnter,BufWinEnter * if &filetype == "vimwiki" | call matchadd('Done', ':DONE:') | else | call matchadd('Done', 'DONE:') | endif |
autocmd VimEnter,BufEnter,BufWinEnter *.md if exists('*complete_info') | inoremap <expr> <M-CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>" | else | inoremap <expr> <M-CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>" | endif |
autocmd VimEnter,BufEnter,BufWinEnter *.md inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
autocmd FileType qf hi! link Search CursorLine
autocmd FileType mail hi! link mailURL Link
autocmd FileType mail set textwidth=0 wrapmargin=0
autocmd FileType mail set spell!
autocmd FileType gitcommit set spell!
autocmd VimEnter * nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" Map

map <M-r> :source ~/.config/nvim/init.vim<cr>:call lightline#update()<cr>:echo "Config reloaded"<cr>
map <C-_> <leader>c<space>
vmap <C-_> <leader>c<space>gv
map <C-l> :bn!<cr>
map <C-h> :bp!<cr>
map <Tab> za
map <M-v> "+p
inoremap <M-v> <Esc>"+pi
vmap <M-c> "+y
map <M-S-Right> :bn!<cr>
map <M-S-Left> :bp!<cr>
map <M-S-k> :bn!<cr>
map <M-S-j> :bp!<cr>
map <M-S-x> :bd!<cr>
map <C-Right> <C-w>l
map <C-Left> <C-w>h
map <C-Up> <C-w>k
map <C-Down> <C-w>j
map <C-l> <C-w>l
map <C-h> <C-w>h
map <C-k> <C-w>k
map <C-j> <C-w>j
map <M-C-l> <C-w>>
map <M-C-h> <C-w><
map <silent> <leader>n :CocCommand explorer<cr>
map <leader>v :vsplit 
map <leader>h :split 
map <Esc> <Esc>:noh<cr>
nnoremap <leader>pi :PlugInstall<cr>
nnoremap <leader>pc :PlugClean<cr>
map <leader>gs :Git<cr>
map <leader>gd :Git diff<cr>
map <leader>gc :Gco<cr>
map <leader>gp :cd %:p:h<cr>:15Term git push origin master<cr>
map <leader>d :cd %:p:h<cr>:pwd<cr>
map <leader>u :UndotreeToggle<cr>
inoremap <M-l> <Esc>:call Indent("right")<cr>
inoremap <M-h> <Esc>:call Indent("left")<cr>

" Commands

try
	command Q qa!
	command W w!
	command Wq wq
	command WQ wq
catch
	echo ""
endtry


" Misc

runtime! ./custom_configs/*.vim

function! SynGroup(...)
	let l:s = synID(line('.'), col('.'), 1)
	if !a:0
		echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
	endif
	return synIDattr(l:s, 'name')
endfun

fu Indent(direction)
	let current_pos = getpos('.')
	if a:direction == "right"
		norm >>
		let current_pos[2] = current_pos[2]
	elseif a:direction == "left"
		norm <<
		let current_pos[2] = current_pos[2]-2
	endif
	call cursor(current_pos[1], current_pos[2]+1)
	call feedkeys('a')
endfu

let g:vimwiki_list = [{'path': '~/.cache/vimwiki/', 
			\ 'syntax': 'markdown', 'ext': '.md'}]

set nocompatible
filetype plugin indent on
filetype plugin on
syntax on

" Hi

colorscheme gruvbox
"hi Normal ctermfg=223 ctermbg=NONE guifg=#ebdbb2 guibg=#282828
"hi CursorLine cterm=NONE ctermbg=236 ctermfg=NONE
hi Folded cterm=BOLD ctermbg=236 guibg=#32302f
hi FoldColumn ctermbg=NONE guibg=NONE
"hi Folded ctermbg=NONE
"hi Folded ctermfg=gray cterm=BOLD
hi SignColumn ctermbg=NONE guibg=NONE

syn match Link "\(https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(in\|uk\|us\|net\|org\|edu\|com\|cc\|br\|jp\|dk\|gs\|de\|xyz\)\(\/[^ ]*\)\?\>"
syn match EmailId #\v[_=a-z\./+0-9-]+\@[a-z0-9._-]+\a{2}#  contains=@NoSpell

hi Link cterm=UNDERLINE ctermfg=blue guifg=#83a598 gui=underline
hi! link EmailId Special
hi Todo ctermbg=yellow ctermfg=235 guibg=#fabd2f guifg=#282828
hi Done ctermbg=green ctermfg=235 guibg=#b8bb26 guifg=#282828

" Set

set number relativenumber
set cursorline
set showtabline=2
set autoindent
set noexpandtab
set tabstop=2
set shiftwidth=2
set splitbelow splitright
set list lcs=tab:\|\ 
set nocompatible
set concealcursor=
set ic
set timeoutlen=200
set formatoptions-=cro
set ignorecase
if &columns <= 120
	set nowrap
endif

if has("persistent_undo")
    set undodir=$HOME/.cache/undotree
    set undofile
endif

