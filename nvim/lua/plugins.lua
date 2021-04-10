local execute = vim.api.nvim_command
local fn = vim.fn
local cmd = vim.api.nvim_command

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

return require('packer').startup(function()

	-- Packer
  use 'wbthomason/packer.nvim'

	-- Colorscheme
  use 'morhetz/gruvbox'

	-- File Nav
	use {
  'nvim-telescope/telescope.nvim',
  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}
  use 'kyazdani42/nvim-tree.lua'

	-- Tabline/Statusline
	use 'kyazdani42/nvim-web-devicons'
	use 'romgrk/barbar.nvim'
	use 'glepnir/galaxyline.nvim'

	-- Git
	---- GitSigns
	use {
		'lewis6991/gitsigns.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			-- Setup highlights before calling setup()
			vim.cmd[[ highlight! link GitSignsAdd GruvboxGreenBold ]]
			vim.cmd[[ highlight! link GitSignsChange GruvboxYellowBold ]]
			vim.cmd[[ highlight! link GitSignsDelete GruvboxRedBold ]]
			require('gitsigns').setup {
				signs = {
					add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
					change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
					delete       = {hl = 'GitSignsDelete', text = '│', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
					topdelete    = {hl = 'GitSignsDelete', text = '│', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
					changedelete = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
				}
			}
		end
	}

	---- Fugitive
	use 'tpope/vim-fugitive'

	-- General Utils
	use 'mbbill/undotree'
	use 'markonm/traces.vim'
	use 'vimlab/split-term.vim'
	use 'jiangmiao/auto-pairs'
	use 'matze/vim-move'
  use 'junegunn/goyo.vim'
	use 'vim-pandoc/vim-pandoc-syntax'
	use 'roxma/vim-tmux-clipboard'
	use 'tmux-plugins/vim-tmux-focus-events'
	use 'liuchengxu/vim-which-key'
	use 'kovetskiy/sxhkd-vim'
	use 'terryma/vim-multiple-cursors'
	use 'junegunn/vim-easy-align'
	use 'bkad/CamelCaseMotion'
	use 'dkarter/bullets.vim'
	use 'andymass/vim-matchup'
	use 'unblevable/quick-scope'
	use 'kien/rainbow_parentheses.vim'

	-- Nvim
	use 'nvim-treesitter/nvim-treesitter'
	use 'terrortylor/nvim-comment'
	use 'norcalli/nvim-colorizer.lua'

end)


