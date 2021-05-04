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
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  CamelCaseMotion = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/CamelCaseMotion"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/barbar.nvim"
  },
  ["bullets.vim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/bullets.vim"
  },
  ["compe-tabnine"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/compe-tabnine"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
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
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lsp-trouble.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/lsp-trouble.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-bqf"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-comment"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-comment"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  popfix = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/popfix"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["quick-scope"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/quick-scope"
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
  ultisnips = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/ultisnips"
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
  ["vim-move"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-move"
  },
  ["vim-pandoc-syntax"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-pandoc-syntax"
  },
  ["vim-ripgrep"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-ripgrep"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-table-mode"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-table-mode"
  },
  ["vim-tmux-clipboard"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-tmux-clipboard"
  },
  ["vim-tmux-focus-events"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-tmux-focus-events"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  },
  ["vim-which-key"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-which-key"
  }
}

time("Defining packer_plugins", false)
-- Config for: lsp-trouble.nvim
time("Config for lsp-trouble.nvim", true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0", "config", "lsp-trouble.nvim")
time("Config for lsp-trouble.nvim", false)
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
