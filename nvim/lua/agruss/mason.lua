require('mason').setup({
    build = ':MasonUpdate',
    cmd = 'Mason',
    opts = {
        ensure_installed = {
            'roslyn',

            'lua-language-server',
            'stylua',

            'typescript-language-server',
            'angular-language-server',

            'dockerfile-language-server',
            'docker-compose-language-service',

            'helm-ls',
            'yaml-language-server',

            'gopls',

            'terraform-ls'
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

