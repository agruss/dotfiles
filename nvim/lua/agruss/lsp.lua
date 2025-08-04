local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
    -- Key mappings for LSP functionality
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
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
    filetypes = { 'ts', 'typescript', 'tsx', 'typescriptreact', 'typescript.tsx' },
    on_attach = on_attach,
    cmd = { 'typescript-language-server', '--stdio' }
})

-- angular

-- docker & docker-compose
require('lspconfig').dockerls.setup({
    filetypes = { 'Dockerfile', 'dockerfile' },
    cmd = { 'docker-langserver', '--stdio' },
    on_attach = on_attach
})

require('lspconfig').docker_compose_language_service.setup({
    filetypes = { 'yaml.docker-compose' },
    cmd = { 'docker-compose-langserver', '--stdio' },
    on_attach = on_attach
})
-- LSP is not attached - the following lines fixes it. Credits goes to https://vi.stackexchange.com/questions/43519/docker-compose-lsp-will-not-attach-to-buffer-nor-automatically-start
function compose_fix()
    local filename = vim.fn.expand('%:t')

    if filename == 'docker-compose.yaml' then
        vim.bo.filetype = 'yaml.docker-compose'
    end
end
vim.cmd[[au BufRead * lua compose_fix()]]

-- helm charts
require('lspconfig').helm_ls.setup({
    settings = {
        ['helm-ls'] = {
            yamlls = {
                path = "yaml-language-server"
            }
        }
    }
})

-- terraform

-- ansible

-- golang
