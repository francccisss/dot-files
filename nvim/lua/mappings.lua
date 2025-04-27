require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local function search_and_replace_visual()
  local search = vim.fn.input "Find: "
  if search == "" then
    return
  end -- Exit if empty

  local replace = vim.fn.input "Replace with: "

  -- Escape special characters to avoid errors in regex
  search = vim.fn.escape(search, "/\\^$.*[]")
  -- Run the substitution only on the selected lines with case-insensitive matching (`gi` flag)
  vim.cmd(string.format("%%s/%s/%s/g", search, replace))
  vim.cmd "nohlsearch"
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

-- Map the function to a keybinding in visual mode
vim.keymap.set("n", "<leader>fr", search_and_replace_visual, { noremap = true, silent = false })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Move block with j and k
map("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Keyboard users
vim.keymap.set("n", "<C-k>", function()
  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = false })
end, {})
-- mouse users + nvimtree users!
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- FZF map
vim.api.nvim_create_user_command("F", function()
  require("telescope.builtin").find_files { default_text = opts.args }
end, { nargs = "?" })

vim.api.nvim_create_user_command("Newf", function()
  local file = opts.args
  local dir = vim.fn.fnamemodify(file, ":h") -- Extracts the directory path
  if dir ~= "" and not vim.loop.fs_stat(dir) then
    vim.fn.mkdir(dir, "p") -- Creates the directory if it doesn't exist
  end
  vim.cmd("edit " .. file) -- Opens the file in Vim
end, { nargs = 1 })

vim.api.nvim_create_user_command("Newd", function()
  local dir = opts.args
  vim.fn.mkdir(dir, "p") -- "p" ensures parent directories are created if needed
end, { nargs = 1 })

-- Force Ctrl+C to behave like Esc in Insert and Visual mode
map("i", "<C-c>", "<Esc>", opts)
map("v", "<C-c>", "<Esc>", opts)
-- Prevent Ctrl+C from triggering Yank or Copy
map("v", "<C-c>", "<Esc>", opts) -- Also in Visual Mode
map("n", "<C-c>", "<Esc>", opts) -- Normal Mode (Optional)n

-- Goto definitio
vim.api.nvim_set_keymap("n", "<C-g>d", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
