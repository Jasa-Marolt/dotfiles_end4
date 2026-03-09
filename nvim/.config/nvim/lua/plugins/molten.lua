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

        -- Keymaps for molten
        vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Molten Init", silent = true })
        vim.keymap.set("n", "<leader>me", ":MoltenEvaluateLine<CR>", { desc = "Molten Evaluate Line", silent = true })
        vim.keymap.set(
            "v",
            "<leader>me",
            ":<C-u>MoltenEvaluateVisual<CR><Esc>",
            { desc = "Molten Evaluate Visual", silent = true }
        )
        
        -- Run current cell based on # %% markers
        vim.keymap.set("n", "<leader>mc", function()
            local current_line = vim.fn.line(".")
            local total_lines = vim.fn.line("$")
            
            -- Find start of cell (search backwards for # %%)
            local start_line = current_line
            for i = current_line, 1, -1 do
                local line = vim.fn.getline(i)
                if line:match("^# %%") then
                    start_line = i + 1
                    break
                end
                if i == 1 then
                    start_line = 1
                end
            end
            
            -- Find end of cell (search forward for next # %%)
            local end_line = total_lines
            for i = current_line + 1, total_lines do
                local line = vim.fn.getline(i)
                if line:match("^# %%") then
                    end_line = i - 1
                    break
                end
            end
            
            -- Select and evaluate the cell
            vim.cmd(string.format("normal! %dGV%dG", start_line, end_line))
            vim.cmd("MoltenEvaluateVisual")
            vim.cmd("normal! \\<Esc>")
        end, { desc = "Molten Run Current Cell", silent = true })
        
        vim.keymap.set("n", "<leader>mr", ":MoltenReevaluateCell<CR>", { desc = "Molten Re-evaluate Cell", silent = true })
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
