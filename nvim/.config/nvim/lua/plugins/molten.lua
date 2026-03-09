return {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    lazy = false,
    build = ":UpdateRemotePlugins",
    config = function()
        -- Configure molten settings
        vim.g.molten_auto_open_output = true
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 20
        vim.g.molten_wrap_output = true
        vim.g.molten_virt_text_output = true
        vim.g.molten_virt_lines_off_by_1 = true -- Perfect for markdown files
        vim.g.molten_auto_init_behavior = "init"

        -- Keymaps for molten
        vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Molten Init", silent = true })
        vim.keymap.set(
            "n",
            "<leader>me",
            ":MoltenEvaluateOperator<CR>",
            { desc = "Molten Evaluate Operator", silent = true }
        )
        vim.keymap.set("n", "<leader>ml", ":MoltenEvaluateLine<CR>", { desc = "Molten Evaluate Line", silent = true })
        vim.keymap.set(
            "v",
            "<leader>me",
            ":<C-u>MoltenEvaluateVisual<CR>gv<Esc>",
            { desc = "Molten Evaluate Visual", silent = true }
        )

        -- Use native MoltenReevaluateCell - automatically finds and runs current cell
        -- This works with # %% markers AND skips # %% [markdown] cells!
        vim.keymap.set(
            "n",
            "<leader>mc",
            ":MoltenReevaluateCell<CR><Esc>",
            { desc = "Molten Run Current Cell", silent = true }
        )

        -- Cell navigation
        vim.keymap.set("n", "<leader>mj", ":MoltenNext<CR>", { desc = "Molten Next Cell", silent = true })
        vim.keymap.set("n", "<leader>mk", ":MoltenPrev<CR>", { desc = "Molten Previous Cell", silent = true })

        vim.keymap.set(
            "n",
            "<leader>mr",
            ":MoltenReevaluateCell<CR>",
            { desc = "Molten Re-evaluate Cell", silent = true }
        )
        vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { desc = "Molten Delete Cell", silent = true })
        vim.keymap.set("n", "<leader>mo", ":MoltenHideOutput<CR>", { desc = "Molten Hide Output", silent = true })
        vim.keymap.set("n", "<leader>mO", ":MoltenShowOutput<CR>", { desc = "Molten Show Output", silent = true })

        -- Run all cells above current line
        vim.keymap.set("n", "<leader>mA", function()
            local current_line = vim.fn.line(".")
            vim.cmd("normal! ggVG")
            vim.cmd(string.format("normal! %dgg", current_line))
            vim.cmd("MoltenEvaluateVisual")
        end, { desc = "Molten Run All Above", silent = true })
    end,
}
