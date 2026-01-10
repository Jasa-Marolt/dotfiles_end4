return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        marks = true,
        registers = true,

        icons = {
            separator = "=",
        },
        spec = {
            { "<leader>b", group = "Buffer" },
            { "<leader>g", group = "Git" },
            { "<leader>r", group = "Run" },
            { "<leader>u", group = "Visuals" },
            { "<leader>s", group = "Search" },
            { "<leader>c", group = "Code act" },
            { "<leader>f", group = "Find files" },
        },
    },

    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}

-- local wk = require("which-key")
-- wk.add({
--     {
--         "<leader>b",
--         group = "Buffer",
--     },
--     {
--         "<leader>g",
--         group = "Git",
--     },
--     {
--         "<leader>r",
--         group = "Run",
--     },
--     {
--         "<leader>u",
--         group = "Visuals",
--     },
--     {
--         "<leader>s",
--         group = "Search",
--     },
--     {
--         "<leader>c",
--         group = "Code act",
--     },
--
--     {
--         "<leader>f",
--         group = "Find files",
--     },
-- })
