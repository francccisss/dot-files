local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd" },
    html = { "prettierd" },
    typescript = { "prettierd" },
    javascript = { "prettierd" },
    python = { "black" },
    json = { "prettierd" },
    c = { "clang-format" },
    cpp = { "clang-format", baseOnStyle = "GNU" },
  },

  format_on_save = {
    -- These options will be passed to confom.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
