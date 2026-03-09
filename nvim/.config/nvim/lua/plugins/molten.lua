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
    vim.keymap.set("v", "<leader>me", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Molten Evaluate Visual", silent = true })
    vim.keymap.set("n", "<leader>mc", ":MoltenReevaluateCell<CR>", { desc = "Molten Re-evaluate Cell", silent = true })
    vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { desc = "Molten Delete Cell", silent = true })
    vim.keymap.set("n", "<leader>mo", ":MoltenHideOutput<CR>", { desc = "Molten Hide Output", silent = true })
    vim.keymap.set("n", "<leader>mO", ":MoltenShowOutput<CR>", { desc = "Molten Show Output", silent = true })
  end,
}
