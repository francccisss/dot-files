local M = {
  filetype = {
    javascript = {
      require("formatter.filetypes.javascript").prettierd,
    },
    typescript = {
      require("formatter.filetypes.typescript").prettierd,
    },
    html = {
      require("formatter.filetypes.html").prettierd,
    },
    ["*"] = {
      -- require("formatter.filetypes.any").remove_trailing_whitespace,
      require("formatter.filetypes.html").prettierd,
    },
  },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  command = "FormatWriteLock",
})

return M
