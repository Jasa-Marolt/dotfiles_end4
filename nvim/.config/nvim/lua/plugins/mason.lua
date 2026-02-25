return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                -- LSP servers
                "lua-language-server",
                "typescript-language-server",
                "eslint-lsp",
                
                -- Linters
                "eslint_d", -- Fast ESLint daemon
                
                -- Formatters
                "prettier",
                "prettierd", -- Fast Prettier daemon
            },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "eslint",
            },
            automatic_installation = true,
        },
    },
}
