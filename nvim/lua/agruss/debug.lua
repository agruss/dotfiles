local dap, dapui = require('dap'), require('dapui')

dap.adapters.coreclr = {
    type = 'executable',
    command = '/usr/local/bin/netcoredbg/netcoredbg',
    args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
    {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        justMyCode = false,
        stopAtEntry = false,
        program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd(), 'file')
        end,
        args = {},
        env = {
            ASPNETCORE_ENVIRONMENT = 'Development',
            ASPNETCORE_URLS = function()
                return vim.fn.input('Url: ',  'http://localhost:')
            end,
        },
        cwd = function()
            return vim.fn.input('Workspace folder: ', vim.fn.getcwd(), 'file')
        end,
        console = 'integratedTerminal'
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

require('dapui').setup({})

-- keybindings
vim.keymap.set('n', '<F5>', '<Cmd>lua require"dap".continue()<CR>', opts)
vim.keymap.set('n', '<F10>', '<Cmd>lua require"dap".step_over()<CR>', opts)
vim.keymap.set('n', '<F11>', '<Cmd>lua require"dap".step_into()<CR>', opts)
vim.keymap.set('n', '<leader>b', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
