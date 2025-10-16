local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
    -- Key mappings for LSP functionality
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('i', '<C-Space>', function() require('cmp').complete() end, opts)
end

local lsps = {
    { 'roslyn',
        root_dir = require('lspconfig.util').root_pattern('*.sln', '*.csproj'),
        filetypes = { 'cs' },
        autostart = true,
        on_attach = on_attach,
        capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities()),
        settings = {
            ['csharp|completion'] = {
                dotnet_show_completion_items_from_unimported_namespaces = true,
                dotnet_show_name_completion_suggetions = true
            },
            ['csharp|formatting'] = {
                dotnet_organize_imports_on_format = true
            },
            ['csharp|auto_insert'] = {
                dotnet_enable_auto_insert = true
            },
            ['navigation'] = {
                dotnet_navigate_to_decompiled_sources = true
            },
        },
    },

    { 'angularls',
    },

    { 'ts_ls',
        filetypes = { 'ts', 'typescript', 'tsx', 'typescriptreact', 'typescript.tsx' },
        on_attach = on_attach,
        cmd = { 'typescript-language-server', '--stdio' }
    },

    { 'dockerls',
        filetypes = { 'Dockerfile', 'dockerfile' },
        cmd = { 'docker-langserver', '--stdio' },
        on_attach = on_attach
    },

    { 'docker_compose_language_service',
        filetypes = { 'yaml.docker-compose' },
        cmd = { 'docker-compose-langserver', '--stdio' },
        on_attach = on_attach
    },

    { 'helm_ls',
        settings = {
            ['helm-ls'] = {
                yamlls = {
                    path = "yaml-language-server"
                }
            }
        }
    },

    { 'terraformls',
        on_attach = on_attach
    },

    { 'gopls',
        on_attach = on_attach,
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_dir = require('lspconfig.util').root_pattern{ 'go.work', 'go.mod', '.git' },
        settings = {
            gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                    unusedparams = true
                },
            }
        }
    },
}

for _, lsp in pairs(lsps) do
    local name, config = lsp[1], lsp[2]
    vim.lsp.enable(name)
    if config then
        vim.lsp.config(name, config)
    end
end

-- LSP is not attached - the following lines fixes it. Credits goes to https://vi.stackexchange.com/questions/43519/docker-compose-lsp-will-not-attach-to-buffer-nor-automatically-start
function compose_fix()
    local filename = vim.fn.expand('%:t')

    if filename == 'docker-compose.yaml' then
        vim.bo.filetype = 'yaml.docker-compose'
    end
end
vim.cmd[[au BufRead * lua compose_fix()]]

-- Format on save
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(args)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
                vim.lsp.buf.format { async = false, id = args.data.client_id }
            end,
        })
    end
})
