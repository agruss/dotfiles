require('mason').setup({
    build = ':MasonUpdate',
    cmd = 'Mason',
    opts = {
        ensure_installed = {
            'roslyn',

            'lua-language-server',
            'stylua',

            'typescript-language-server' 
        }
    },
    registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry'
    }
})
--require('mason-lspconfig').setup({
--    ensure_installed = { }
--})

