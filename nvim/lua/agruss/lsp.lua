local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
    -- Key mappings for LSP functionality
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-Space>', function() require('cmp').complete() end, opts)

    -- Formatting command
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end,

-- Set up the Roslyn LSP server
require('roslyn').setup({
    dotnet_cmd = "dotnet",
    on_attach = on_attach,
        -- Enable formatting
--        client.resolved_capabilities.document_formatting = true
--        client.resolved_capabilities.document_range_formatting = true
    capabilities = require('cmp_nvim_lsp').default_capabilities()
})

