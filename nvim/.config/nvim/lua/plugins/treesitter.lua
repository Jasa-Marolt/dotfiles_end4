return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {

        ensure_installed = {
            "bash",
            "cpp",
            "c",
            "diff",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "printf",
            "python",
            "query",
            "regex",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "python",
        },

        -- Enable syntax highlighting
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },

        -- Enable incremental selection
        incremental_selection = {
            enable = true,
        },

        -- Enable indentation
        indent = {
            enable = true,
        },
    },
}
