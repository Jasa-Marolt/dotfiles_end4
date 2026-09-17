-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "x", "o" }, "č", "[", { remap = true })
vim.keymap.set({ "n", "x", "o" }, "ć", "]", { remap = true })

vim.keymap.set("t", "<C-e>", [[<C-\><C-n>]], { noremap = true })

vim.keymap.set({ "n", "x" }, "j", "jzz", { remap = false })
vim.keymap.set({ "n", "x" }, "k", "kzz", { remap = false })
