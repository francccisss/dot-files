-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.colorscheme='gruvbox-material'
lvim.plugins={
  { 'shaunsingh/nord.nvim' },
  -- apprentice dependency
  { 'rktjmp/lush.nvim' },
  { 'adisen99/apprentice.nvim' },
  --
  { 'PHSix/nvim-hybrid' },
  { 'Yazeed1s/minimal.nvim' },
{'sainnhe/gruvbox-material'}
}
lvim.transparent_window     = true

lvim.format_on_save.enabled = true
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = 'prettierd',
    { "--print-width", "150" },
    { "--line-width",  "100" },
    filetypes = { "typescript", "typescriptreact", "javascript", "react", "css", "react", "lua" },
  }
}
lvim.builtin.terminal.open_mapping = "<c-t>"
