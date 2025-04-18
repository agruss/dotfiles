local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
    -- Key mappings for LSP functionality
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.keymap.set('i', '<C-Space>', function() require('cmp').complete() end, opts)

end,

-- csharp
require('roslyn').setup({
    root_dir = require('lspconfig.util').root_pattern('*.sln', '*.csproj'),
    filetypes = { 'cs' },
    autostart = true,
    on_attach = on_attach,
    capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())
})

-- typescript
require('lspconfig').ts_ls.setup({
    filetypes = { 'ts', 'typescript', 'typescript.tsx' },
    on_attach = on_attach,
    cmd = { 'typescript-language-server', '--stdio' }
})

-- angular

-- docker

-- helm charts

-- terraform

-- ansible

-- golang
