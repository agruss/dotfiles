-- fat cursor
vim.opt.guicursor = ""

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 50

vim.g.mapleader = " "

vim.diagnostic.config({
    virtual_text = true
})

-- global mappings
vim.keymap.set('n', '<TAB>', '<cmd>bnext<CR>')
vim.keymap.set('n', '<leader>sD', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.keymap.set('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', opts)
vim.keymap.set('n', '<leader>.', vim.lsp.buf.code_action, opts)
