-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- typescript
lspconfig.ts_ls.setup {}

lspconfig.denols.setup {
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
}

lspconfig.ts_ls.setup {
  root_dir = lspconfig.util.root_pattern "package.json",
  single_file_support = false,
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
    "gopls",
  },
  filetypes = {
    "go",
    "gomod",
    "gowork",
    "gotmpl",
  },
}

lspconfig.clangd.setup {
  cmd = { "clangd", "--clang-tidy", "--completion-style=detailed" }, filetypes = {
  "c",
  "cpp",
},
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(_, bufnr)
    -- Enable keybinds for LSP (optional)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  end,
}
