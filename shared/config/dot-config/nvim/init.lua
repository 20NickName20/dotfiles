require("config.lazy")
require("config.colors")

--- Nvim Config ---
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight the line where the cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 5

-- Show <tab> and trailing spaces
vim.o.list = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s) See `:help 'confirm'`
vim.o.confirm = true

-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

--- Clipboard
vim.opt.clipboard = "unnamedplus"

--- End nvim configs ---

vim.lsp.config('*', {
    root_markers = { '.git' }
})

vim.lsp.config('rust_analyzer', {
    textDocument = {
        completion = {
            deprecatedSupport = false
        }
    }
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
})

-- Vars --
local tsbuiltin = require("telescope.builtin")
local map = vim.keymap.set

-- Keymap --
map({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<leader>e", ":Explore<CR>", { silent = true, noremap = true })
map("n", "<leader>f", tsbuiltin.find_files, { desc = "Telescope find files" })
map('n', '<leader>b', function() tsbuiltin.buffers({
    sort_mru=true,
    ignore_current_buffer=true
}) end, { desc = "Telescope find buffers" })
map('n', '<leader>r', tsbuiltin.lsp_references, { desc = "Telescope find references" })
map('n', '<leader>d', tsbuiltin.diagnostics, { desc = "Telescope find references" })
