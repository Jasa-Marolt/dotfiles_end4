-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.keymap.set({ "n", "x", "o" }, "č", "[", { remap = true })
vim.keymap.set({ "n", "x", "o" }, "ć", "]", { remap = true })
vim.keymap.set("t", "<C-e>", [[<C-\><C-n>]], { noremap = true })
vim.cmd([[
augroup kitty_mp
    autocmd!
    au VimEnter *  :silent !kitty @ --to $KITTY_LISTEN_ON set-spacing padding=0 margin=0
    au VimLeave *  :silent !kitty @ --to $KITTY_LISTEN_ON set-spacing padding=20 margin=10
augroup END
]])
