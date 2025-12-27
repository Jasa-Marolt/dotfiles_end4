-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.termguicolors = true

vim.keymap.set("n", "<leader>cne", function()
  vim.api.nvim_exec2("!ninja -C build && ./build/main", {})
end, { silent = true })

-- ctrl+/ opens terminal
vim.keymap.set("n", "<c-/>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })

-- vim.keymap.set("n", "<leader><leader>", function()
--   require("telescope.builtin").files({ cwd = vim.fn.getcwd() })
-- end, { desc = "Find Files (CWD)" })
