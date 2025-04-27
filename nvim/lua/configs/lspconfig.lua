-- Load NvChad's default LSP config
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- LSPs with default config
local servers = { "html", "cssls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Deno
lspconfig.denols.setup {
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
}

-- TypeScript
lspconfig.ts_ls.setup {
  root_dir = lspconfig.util.root_pattern "package.json",
  single_file_support = false,
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- Python
lspconfig.pyright.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
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

-- Go
lspconfig.gopls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
}

-- C / C++
lspconfig.clangd.setup {
  cmd = { "clangd" },
  filetypes = { "c", "cpp" },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  end,
}
