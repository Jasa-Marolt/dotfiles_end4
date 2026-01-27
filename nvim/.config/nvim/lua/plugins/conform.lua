return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- This triggers the plugin before saving
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            rust = { "rustfmt" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            html = { "prettier" },
            cpp = { "clang-format" },
            c = { "clang-format" },
        },
        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
            },
            ["clang-format"] = {
                prepend_args = { "--style={IndentWidth: 4}" },
            },
            prettier = {
                prepend_args = { "--tab-width", "4" },
            },
            prettierd = {
                prepend_args = { "--tab-width", "4" },
            },
        },
        -- Correct way to set global defaults
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
}

