-- Example configuations here: https://github.com/mattn/efm-langserver

-- Lua
local lua_args = require("lsp.lua")

-- sh
local sh_args = require("lsp.sh")

-- JS/TS, html, css, json
local tsserver = require("lsp.tsserver")
local tsserver_args = tsserver.tsserver_args
local prettier = tsserver.prettier

require "lspconfig".efm.setup {
  -- init_options = {initializationOptions},
  cmd = {"efm-langserver"},
  root_dir = vim.loop.cwd,
  init_options = {documentFormatting = true, codeAction = true},
  filetypes = {"lua", "sh", "javascriptreact", "javascript", "html", "css", "json", "yaml"},
  settings = {
    rootMarkers = {".git/"},
    languages = {
      lua = lua_args,
      sh = sh_args,
      javascript = tsserver_args,
      javascriptreact = tsserver_args,
      html = {prettier},
      css = {prettier},
      json = {prettier},
      yaml = {prettier}
    }
  }
}
