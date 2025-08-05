require('conform').setup({
    format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
    },
    formatter_by_ft = {
        typescript = { 'prettier' },
        cs = { 'dotnet format' },
        go = { 'gofmt -w .', 'goimports' },
    }
})

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '',
    callback = function(args)
        require('conform').format({ bufnr = args.buf })
    end,
})
