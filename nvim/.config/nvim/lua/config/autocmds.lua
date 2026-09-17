-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

vim.cmd([[
augroup kitty_mp
    autocmd!
    au VimEnter *  :silent !kitty @ --to $KITTY_LISTEN_ON set-spacing padding=0 margin=0
    au VimLeave *  :silent !kitty @ --to $KITTY_LISTEN_ON set-spacing padding=20 margin=10
augroup END
]])
