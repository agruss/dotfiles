local dap, dapui = require('dap'), require('dapui')

require('dapui').setup({})

dap.adapters.coreclr = {
    type = 'executable',
    command = '/usr/local/bin/netcoredbg/netcoredbg',
    args = { '--interpreter=vscode'  }
}

dap.configurations.cs = {
    {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
    },
}

-- closing & opening debug window
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

-- keybindings
vim.keymap.set('n', '<F5>', '<Cmd>lua require"dap".continue()<CR>', opts)
vim.keymap.set('n', '<F10>', '<Cmd>lua require"dap".step_over()<CR>', opts)
vim.keymap.set('n', '<F11>', '<Cmd>lua require"dap".step_into()<CR>', opts)
vim.keymap.set('n', '<leader>b', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
