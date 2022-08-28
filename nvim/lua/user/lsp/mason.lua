local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

local status_ok_2, lspconfig = pcall(require, "lspconfig")
if not status_ok_2 then
  return
end

local servers = {
  "cssls",
  "cssmodules_ls",
  "emmet_ls",
  "html",
  "jsonls",
  "sumneko_lua",
  "tsserver",
  "pyright",
  "yamlls",
  "bashls",
  "clangd",
  "rust_analyzer",
  -- "tflint",
  -- "terraformls",
  -- "taplo",
  -- "lemminx",
  -- "jdtls",
  -- "solc",
  -- "solidity_ls",
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local handlers = require("user.lsp.handlers")

mason_lspconfig.setup_handlers({
  function(server_name) -- default handler (optional)
    local opts = {
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities,
    }

    if server_name == "sumneko_lua" then
      opts.settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      }
    end

    lspconfig[server_name].setup(opts)
  end,
})
