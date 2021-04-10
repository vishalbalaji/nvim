" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  CamelCaseMotion = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/CamelCaseMotion"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/barbar.nvim"
  },
  ["bullets.vim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/bullets.vim"
  },
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n�\5\0\0\5\0\21\0\0316\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\5\0'\2\6\0B\0\2\0029\0\a\0005\2\19\0005\3\t\0005\4\b\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\3=\3\20\2B\0\2\1K\0\1\0\nsigns\1\0\0\17changedelete\1\0\4\ttext\b│\vlinehl\21GitSignsChangeLn\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\14topdelete\1\0\4\ttext\b│\vlinehl\21GitSignsDeleteLn\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\vdelete\1\0\4\ttext\b│\vlinehl\21GitSignsDeleteLn\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\vchange\1\0\4\ttext\b│\vlinehl\21GitSignsChangeLn\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\badd\1\0\0\1\0\4\ttext\b│\vlinehl\18GitSignsAddLn\ahl\16GitSignsAdd\nnumhl\18GitSignsAddNr\nsetup\rgitsigns\frequire4 highlight! link GitSignsDelete GruvboxRedBold 7 highlight! link GitSignsChange GruvboxYellowBold 3 highlight! link GitSignsAdd GruvboxGreenBold \bcmd\bvim\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/goyo.vim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-comment"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-comment"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["quick-scope"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/quick-scope"
  },
  ["rainbow_parentheses.vim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/rainbow_parentheses.vim"
  },
  ["split-term.vim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/split-term.vim"
  },
  ["sxhkd-vim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/sxhkd-vim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["traces.vim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/traces.vim"
  },
  undotree = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-matchup"
  },
  ["vim-move"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-move"
  },
  ["vim-multiple-cursors"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-multiple-cursors"
  },
  ["vim-pandoc-syntax"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-pandoc-syntax"
  },
  ["vim-tmux-clipboard"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-tmux-clipboard"
  },
  ["vim-tmux-focus-events"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-tmux-focus-events"
  },
  ["vim-which-key"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-which-key"
  }
}

-- Config for: gitsigns.nvim
try_loadstring("\27LJ\2\n�\5\0\0\5\0\21\0\0316\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\5\0'\2\6\0B\0\2\0029\0\a\0005\2\19\0005\3\t\0005\4\b\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\3=\3\20\2B\0\2\1K\0\1\0\nsigns\1\0\0\17changedelete\1\0\4\ttext\b│\vlinehl\21GitSignsChangeLn\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\14topdelete\1\0\4\ttext\b│\vlinehl\21GitSignsDeleteLn\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\vdelete\1\0\4\ttext\b│\vlinehl\21GitSignsDeleteLn\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\vchange\1\0\4\ttext\b│\vlinehl\21GitSignsChangeLn\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\badd\1\0\0\1\0\4\ttext\b│\vlinehl\18GitSignsAddLn\ahl\16GitSignsAdd\nnumhl\18GitSignsAddNr\nsetup\rgitsigns\frequire4 highlight! link GitSignsDelete GruvboxRedBold 7 highlight! link GitSignsChange GruvboxYellowBold 3 highlight! link GitSignsAdd GruvboxGreenBold \bcmd\bvim\0", "config", "gitsigns.nvim")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
