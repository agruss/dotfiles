require('telescope').setup({
    defaults = { 
        file_ignore_patterns = { 'node_modules', 'bin', 'obj', '.next' } 
    }
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fs', builtin.git_status, { }) 
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") }) 
end)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
