-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "tsserver", "pyright", "gopls", "tailwindcss" }

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
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
        autoImportCompletions = true,
        autoSearchPaths = true,
      },
    },
  },
}

lspconfig.gopls.setup {
  cmd = {
    "gopls"
  },
  filetypes = {
    "go", "gomod", "gowork", "gotmpl"
  }
}
