-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.keymap.set("n", "<leader>cne", function()
  --vim.api.nvim_exec2('!echo "-------------------------------NEWLINE---------------------------------"', {})
  vim.api.nvim_exec2("!ninja -C build && ./build/main", {})
end, { silent = true })

vim.keymap.set("n", "<c-/>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })

--
