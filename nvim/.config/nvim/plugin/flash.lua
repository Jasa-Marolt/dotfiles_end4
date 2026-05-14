vim.pack.add({
  "https://github.com/folke/flash.nvim",
})

require("flash").setup()

vim.keymap.set("n", "gs", function()
  require("flash").jump()
end, { desc = "Flash" })
vim.keymap.set("n", "gs", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "gr", function()
  require("flash").remote()
end, {
  desc = "Remote Flash"
})
vim.keymap.set({ "o", "x" }, "gR", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter search" })

vim.keymap.set("c", "g<C-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash search" })
