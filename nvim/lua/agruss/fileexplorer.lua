require('nvim-tree').setup({
    sort = {
        sorter = 'case_sensitive'
    },
    view = {
        width = 30
    },
})

vim.keymap.set('n', '<leader>e', ':NvimTreeFindFile<CR>', opts)
