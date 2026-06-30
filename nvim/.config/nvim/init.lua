-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.keymap.set({ "n", "x", "o" }, "č", "[", { remap = true })
vim.keymap.set({ "n", "x", "o" }, "ć", "]", { remap = true })
