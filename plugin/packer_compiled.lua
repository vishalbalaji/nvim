-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

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
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/vishal/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["aerial.nvim"] = {
    config = { "\27LJ\2\n¬\2\0\0\6\0\18\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\3=\3\a\2B\0\2\0016\0\b\0009\0\t\0009\0\n\0'\2\v\0'\3\f\0'\4\r\0005\5\14\0B\0\5\0016\0\b\0009\0\t\0009\0\n\0'\2\v\0'\3\15\0'\4\16\0005\5\17\0B\0\5\1K\0\1\0\1\0\2\fnoremap\1\vsilent\2\azA\f<S-Tab>\1\0\2\fnoremap\1\vsilent\2\aza\n<Tab>\6n\20nvim_set_keymap\bapi\bvim\vlayout\14max_width\1\2\0\0\3\30\1\0\1\nwidth\4ö≥ÊÃ\tô≥¶˛\3\1\0\3\17manage_folds\1\23link_folds_to_tree\1\23link_tree_to_folds\1\nsetup\vaerial\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/aerial.nvim",
    url = "https://github.com/stevearc/aerial.nvim"
  },
  ["bufdelete.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/bufdelete.nvim",
    url = "https://github.com/famiu/bufdelete.nvim"
  },
  ["bufresize.nvim"] = {
    config = { "\27LJ\2\nÃ\1\0\0\5\0\f\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\a\0005\3\3\0004\4\0\0=\4\4\0035\4\5\0=\4\6\3=\3\b\0025\3\t\0004\4\0\0=\4\4\0035\4\n\0=\4\6\3=\3\v\2B\0\2\1K\0\1\0\vresize\1\2\0\0\15VimResized\1\0\1\14increment\3\5\rregister\1\0\0\19trigger_events\1\3\0\0\16BufWinEnter\rWinEnter\tkeys\1\0\0\nsetup\14bufresize\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/bufresize.nvim",
    url = "https://github.com/kwkarlwang/bufresize.nvim"
  },
  ["bullets.vim"] = {
    config = { "\27LJ\2\nÑ\1\0\0\4\0\6\0\f6\0\0\0009\0\1\0006\1\3\0'\3\4\0B\1\2\0029\1\2\1=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\5\0K\0\1\0\22bullets_pad_right\22user.autocommands\frequire\31bullets_enabled_file_types\6g\bvim\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/bullets.vim",
    url = "https://github.com/dkarter/bullets.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/cmp-emoji",
    url = "https://github.com/hrsh7th/cmp-emoji"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-pandoc-references"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/cmp-pandoc-references",
    url = "https://github.com/jc-doyle/cmp-pandoc-references"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-under-comparator"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/cmp-under-comparator",
    url = "https://github.com/lukas-reineke/cmp-under-comparator"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["doom-one.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/doom-one.nvim",
    url = "https://github.com/NTBBloodbath/doom-one.nvim"
  },
  ["dressing.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\nU\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\vwindow\1\0\0\1\0\1\nblend\3\0\nsetup\vfidget\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["foldhue.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\venable\ffoldhue\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/foldhue.nvim",
    url = "https://github.com/milisims/foldhue.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["git-conflict.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17git-conflict\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/git-conflict.nvim",
    url = "https://github.com/akinsho/git-conflict.nvim"
  },
  ["gitignore-vim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/gitignore-vim",
    url = "https://github.com/benknoble/gitignore-vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["headlines.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/headlines.nvim",
    url = "https://github.com/lukas-reineke/headlines.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp-inlayhints.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/lsp-inlayhints.nvim",
    url = "https://github.com/lvimuser/lsp-inlayhints.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["noice.nvim"] = {
    config = { "\27LJ\2\nx\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\14popupmenu\1\0\1\fenabled\1\fcmdline\1\0\0\1\0\1\tview\fcmdline\nsetup\nnoice\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/opt/noice.nvim",
    url = "https://github.com/folke/noice.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-FeMaco.lua"] = {
    config = { 'require("femaco").setup()' },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-FeMaco.lua",
    url = "https://github.com/AckslD/nvim-FeMaco.lua"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-cokeline"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-cokeline",
    url = "https://github.com/noib3/nvim-cokeline"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/NvChad/nvim-colorizer.lua"
  },
  ["nvim-gomove"] = {
    config = { "\27LJ\2\nI\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\17map_defaults\1\nsetup\vgomove\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-gomove",
    url = "https://github.com/booperlv/nvim-gomove"
  },
  ["nvim-lastplace"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-lastplace\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-lastplace",
    url = "https://github.com/ethanholz/nvim-lastplace"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-navic"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-navic",
    url = "https://github.com/SmiteshP/nvim-navic"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\nM\0\1\5\0\4\0\a6\1\0\0009\1\1\0019\1\2\1\18\3\0\0005\4\3\0B\1\3\1K\0\1\0\1\0\1\14focusable\1\24nvim_win_set_config\bapi\bvimà\1\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\1K\0\1\0\fon_open\1\0\4\14max_width\0032\21background_color\f#000000\ftimeout\3Ë\a\vstages\tfade\0\nsetup\vnotify\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  nvim_context_vt = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/nvim_context_vt",
    url = "https://github.com/haringsrob/nvim_context_vt"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["pretty-fold.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/pretty-fold.nvim",
    url = "https://github.com/anuvyklack/pretty-fold.nvim"
  },
  ["quick-scope"] = {
    config = { "\27LJ\2\n‡\1\0\0\5\0\n\0\0196\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\4\0009\0\5\0)\2\0\0'\3\6\0005\4\a\0B\0\4\0016\0\0\0009\0\4\0009\0\5\0)\2\0\0'\3\b\0005\4\t\0B\0\4\1K\0\1\0\1\0\2\afg\f#ecbe7b\rstandout\2\24QuickScopeSecondary\1\0\2\afg\f#98be6b\rstandout\2\22QuickScopePrimary\16nvim_set_hl\bapi\1\5\0\0\6f\6F\6t\6T\25qs_highlight_on_keys\6g\bvim\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/quick-scope",
    url = "https://github.com/unblevable/quick-scope"
  },
  ["refactoring.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/refactoring.nvim",
    url = "https://github.com/ThePrimeagen/refactoring.nvim"
  },
  ["schemastore.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/schemastore.nvim",
    url = "https://github.com/b0o/schemastore.nvim"
  },
  ["smart-splits.nvim"] = {
    config = { "\27LJ\2\nÙ\1\0\0\b\0\15\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\f\0005\4\n\0006\5\0\0'\a\b\0B\5\2\0029\5\t\5=\5\v\4=\4\r\3=\3\14\2B\0\2\1K\0\1\0\16resize_mode\nhooks\1\0\0\ron_leave\1\0\0\rregister\14bufresize\21ignored_buftypes\1\2\0\0\rNvimTree\22ignored_filetypes\1\0\0\1\4\0\0\vnofile\rquickfix\vprompt\nsetup\17smart-splits\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/smart-splits.nvim",
    url = "https://github.com/mrjones2014/smart-splits.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n≤\1\0\0\6\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0005\3\6\0005\4\3\0005\5\4\0=\5\5\4=\4\a\0035\4\b\0=\4\t\3=\3\v\2B\0\2\1K\0\1\0\rkeywords\1\0\0\tTODO\1\0\1\ncolor\fwarning\vCREDIT\1\0\0\balt\1\2\0\0\vTHANKS\1\0\2\ncolor\tinfo\ticon\t‚ò∫ \nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\n{\0\1\b\0\b\0\n6\1\0\0009\1\1\0019\1\2\0019\3\3\0'\4\4\0'\5\5\0'\6\6\0005\a\a\0B\1\6\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2\22<cmd>Bdelete!<CR>\6q\6n\nbufnr\24nvim_buf_set_keymap\bapi\bvimÄ\1\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\1K\0\1\0\fon_open\1\0\3\20start_in_insert\1\17persist_mode\2\20shade_terminals\1\0\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nÜ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\nsigns\1\0\0\1\0\5\nerror\bÔÅó\fwarning\bÔÅ±\nother\bÔÅô\16information\bÔÅö\thint\bÔ†¥\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["winbar.nvim"] = {
    loaded = true,
    path = "/home/vishal/.local/share/nvim/site/pack/packer/start/winbar.nvim",
    url = "https://github.com/fgheng/winbar.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-lastplace
time([[Config for nvim-lastplace]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-lastplace\frequire\0", "config", "nvim-lastplace")
time([[Config for nvim-lastplace]], false)
-- Config for: smart-splits.nvim
time([[Config for smart-splits.nvim]], true)
try_loadstring("\27LJ\2\nÙ\1\0\0\b\0\15\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\f\0005\4\n\0006\5\0\0'\a\b\0B\5\2\0029\5\t\5=\5\v\4=\4\r\3=\3\14\2B\0\2\1K\0\1\0\16resize_mode\nhooks\1\0\0\ron_leave\1\0\0\rregister\14bufresize\21ignored_buftypes\1\2\0\0\rNvimTree\22ignored_filetypes\1\0\0\1\4\0\0\vnofile\rquickfix\vprompt\nsetup\17smart-splits\frequire\0", "config", "smart-splits.nvim")
time([[Config for smart-splits.nvim]], false)
-- Config for: nvim-ts-autotag
time([[Config for nvim-ts-autotag]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0", "config", "nvim-ts-autotag")
time([[Config for nvim-ts-autotag]], false)
-- Config for: git-conflict.nvim
time([[Config for git-conflict.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17git-conflict\frequire\0", "config", "git-conflict.nvim")
time([[Config for git-conflict.nvim]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\nM\0\1\5\0\4\0\a6\1\0\0009\1\1\0019\1\2\1\18\3\0\0005\4\3\0B\1\3\1K\0\1\0\1\0\1\14focusable\1\24nvim_win_set_config\bapi\bvimà\1\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\1K\0\1\0\fon_open\1\0\4\14max_width\0032\21background_color\f#000000\ftimeout\3Ë\a\vstages\tfade\0\nsetup\vnotify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: foldhue.nvim
time([[Config for foldhue.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\venable\ffoldhue\frequire\0", "config", "foldhue.nvim")
time([[Config for foldhue.nvim]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\vwindow\1\0\0\1\0\1\nblend\3\0\nsetup\vfidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)
-- Config for: nvim-gomove
time([[Config for nvim-gomove]], true)
try_loadstring("\27LJ\2\nI\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\17map_defaults\1\nsetup\vgomove\frequire\0", "config", "nvim-gomove")
time([[Config for nvim-gomove]], false)
-- Config for: bullets.vim
time([[Config for bullets.vim]], true)
try_loadstring("\27LJ\2\nÑ\1\0\0\4\0\6\0\f6\0\0\0009\0\1\0006\1\3\0'\3\4\0B\1\2\0029\1\2\1=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\5\0K\0\1\0\22bullets_pad_right\22user.autocommands\frequire\31bullets_enabled_file_types\6g\bvim\0", "config", "bullets.vim")
time([[Config for bullets.vim]], false)
-- Config for: bufresize.nvim
time([[Config for bufresize.nvim]], true)
try_loadstring("\27LJ\2\nÃ\1\0\0\5\0\f\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\a\0005\3\3\0004\4\0\0=\4\4\0035\4\5\0=\4\6\3=\3\b\0025\3\t\0004\4\0\0=\4\4\0035\4\n\0=\4\6\3=\3\v\2B\0\2\1K\0\1\0\vresize\1\2\0\0\15VimResized\1\0\1\14increment\3\5\rregister\1\0\0\19trigger_events\1\3\0\0\16BufWinEnter\rWinEnter\tkeys\1\0\0\nsetup\14bufresize\frequire\0", "config", "bufresize.nvim")
time([[Config for bufresize.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nÜ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\nsigns\1\0\0\1\0\5\nerror\bÔÅó\fwarning\bÔÅ±\nother\bÔÅô\16information\bÔÅö\thint\bÔ†¥\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: quick-scope
time([[Config for quick-scope]], true)
try_loadstring("\27LJ\2\n‡\1\0\0\5\0\n\0\0196\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\4\0009\0\5\0)\2\0\0'\3\6\0005\4\a\0B\0\4\0016\0\0\0009\0\4\0009\0\5\0)\2\0\0'\3\b\0005\4\t\0B\0\4\1K\0\1\0\1\0\2\afg\f#ecbe7b\rstandout\2\24QuickScopeSecondary\1\0\2\afg\f#98be6b\rstandout\2\22QuickScopePrimary\16nvim_set_hl\bapi\1\5\0\0\6f\6F\6t\6T\25qs_highlight_on_keys\6g\bvim\0", "config", "quick-scope")
time([[Config for quick-scope]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\n{\0\1\b\0\b\0\n6\1\0\0009\1\1\0019\1\2\0019\3\3\0'\4\4\0'\5\5\0'\6\6\0005\a\a\0B\1\6\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2\22<cmd>Bdelete!<CR>\6q\6n\nbufnr\24nvim_buf_set_keymap\bapi\bvimÄ\1\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\1K\0\1\0\fon_open\1\0\3\20start_in_insert\1\17persist_mode\2\20shade_terminals\1\0\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: aerial.nvim
time([[Config for aerial.nvim]], true)
try_loadstring("\27LJ\2\n¬\2\0\0\6\0\18\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\3=\3\a\2B\0\2\0016\0\b\0009\0\t\0009\0\n\0'\2\v\0'\3\f\0'\4\r\0005\5\14\0B\0\5\0016\0\b\0009\0\t\0009\0\n\0'\2\v\0'\3\15\0'\4\16\0005\5\17\0B\0\5\1K\0\1\0\1\0\2\fnoremap\1\vsilent\2\azA\f<S-Tab>\1\0\2\fnoremap\1\vsilent\2\aza\n<Tab>\6n\20nvim_set_keymap\bapi\bvim\vlayout\14max_width\1\2\0\0\3\30\1\0\1\nwidth\4ö≥ÊÃ\tô≥¶˛\3\1\0\3\17manage_folds\1\23link_folds_to_tree\1\23link_tree_to_folds\1\nsetup\vaerial\frequire\0", "config", "aerial.nvim")
time([[Config for aerial.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n≤\1\0\0\6\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0005\3\6\0005\4\3\0005\5\4\0=\5\5\4=\4\a\0035\4\b\0=\4\t\3=\3\v\2B\0\2\1K\0\1\0\rkeywords\1\0\0\tTODO\1\0\1\ncolor\fwarning\vCREDIT\1\0\0\balt\1\2\0\0\vTHANKS\1\0\2\ncolor\tinfo\ticon\t‚ò∫ \nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: nvim-FeMaco.lua
time([[Config for nvim-FeMaco.lua]], true)
require("femaco").setup()
time([[Config for nvim-FeMaco.lua]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'noice.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
