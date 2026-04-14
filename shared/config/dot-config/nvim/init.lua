require("config.lazy")
require("config.colors")

--- Nvim Config ---
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight the line where the cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

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

