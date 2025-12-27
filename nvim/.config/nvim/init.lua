vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
vim.opt.termguicolors = true


local map = vim.keymap.set

-- Move between windows using Control + hjkl
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })


