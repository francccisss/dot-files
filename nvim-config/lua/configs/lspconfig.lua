-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "tsserver", "pyright" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
}

lspconfig.pyright.setup {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
        autoImportCompletions = true,
        autoSearchPaths = true,
      },
    },
  },
}

-- lspconfig.pylsp.setup {
--   settings = {
--     pylsp = {
--       plugins = {
--         jedi_completion ={
--           fuzzy = true
--         },
--         pycodestyle = {
--           ignore = { "W391" },
--           maxLineLength = 100,
--         },
--       },
--     },
--   },
-- }
