return {
    -- In-buffer markdown rendering
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        config = function()
            require("render-markdown").setup({
                heading = {
                    enabled = true,
                    icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
                },
                code = {
                    enabled = true,
                    style = "full",
                    left_pad = 2,
                    right_pad = 2,
                },
            })
        end,
        keys = {
            { "<leader>mr", ":RenderMarkdown toggle<CR>", desc = "Toggle Markdown Render" },
        },
    },
    
    -- Browser-based preview (optional)
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        keys = {
            { "<leader>mp", ":MarkdownPreview<CR>", desc = "Markdown Preview (Browser)" },
            { "<leader>ms", ":MarkdownPreviewStop<CR>", desc = "Markdown Preview Stop" },
        },
    },
}
