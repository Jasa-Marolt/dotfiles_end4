-- nvim --headless +qall 2> nvim_error.log && cat nvim_error.log
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set Python provider for remote plugins
vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
vim.opt.termguicolors = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds"

require("config.lazy")
require("config.autocmd")
require("config.man")
