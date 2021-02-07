call plug#begin()

"" Colorscheme
Plug 'morhetz/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'

"" Lightline
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

"" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"" General Utils
Plug 'markonm/traces.vim'
Plug 'matze/vim-move'
Plug 'unblevable/quick-scope'
Plug 'junegunn/goyo.vim'
Plug 'vimlab/split-term.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mbbill/undotree'
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'kovetskiy/sxhkd-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'terryma/vim-multiple-cursors'

"" Coding utils
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/rainbow_parentheses.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'dkarter/bullets.vim'
Plug 'goerz/jupytext.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'dense-analysis/ale'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'

call plug#end()
