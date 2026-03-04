return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    opts = {},
    config = function()
        require("refactoring").setup({
            prompt_func_return_type = {
                go = false,
                java = false,

                cpp = false,
                c = false,
                h = false,
                hpp = false,
                cxx = false,
            },
            prompt_func_param_type = {
                go = false,
                java = false,

                cpp = false,
                c = false,
                h = false,
                hpp = false,
                cxx = false,
            },
            printf_statements = {
                cpp = {
                    'printf("DEBUG: %%15s, FUNC: %%15s, LINE: %%d\\n" ,__FILE__,"%s", __LINE__);\n',
                },
            },
            print_var_statements = {
                cpp = {
                    'printf("VAR %%10s%%d at line %%d\\n", "%s", %s, __LINE__ );\n',
                },
            },
            show_success_message = false, -- shows a message with information about the refactor on success
            -- i.e. [Refactor] Inlined 3 variable occurrences
        })
        vim.keymap.set({ "n", "x" }, "<leader>rr", function()
            require("refactoring").select_refactor()
        end, { desc = "Refactor (Snacks)" })
        -- printf("test 1(%d): \n", __LINE__);
        vim.keymap.set("n", "<leader>rp", function()
            require("refactoring").debug.printf({ below = true })
        end, { desc = "Print line num" })

        -- Print var

        vim.keymap.set({ "x", "n" }, "<leader>rv", function()
            require("refactoring").debug.print_var({})
        end, { desc = "Print var" })
        -- Supports both visual and normal mode

        vim.keymap.set("n", "<leader>rc", function()
            require("refactoring").debug.cleanup({})
        end, { desc = "cleanup" })
    end,
}
