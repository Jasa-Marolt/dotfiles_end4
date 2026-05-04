return {
    {
        "williamboman/mason.nvim",
        opts = {}, -- masonry.nvim doesn't use ensure_installed here
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "eslint",
                "pyright", -- Added pyright here for LSP
            },
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                -- LSP servers
                "lua-language-server",
                "typescript-language-server",
                "eslint-lsp",
                "pyright",

                -- Linters & Formatters
                "ruff", -- Python Linter/Formatter
                "eslint_d", -- JS/TS Linter
                "prettier", -- Formatter
                "prettierd",
            },
        },
    },
}
