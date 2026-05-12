vim.schedule(function()
  vim.pack.add({ "https://github.com/folke/which-key.nvim" })

  require("which-key").setup()
  require("which-key").add({
    { "<leader>f", group = "Find" },
    { "<leader>w", group = "Window" },
    { "<leader>g", group = "Git" },
    { "<leader>h", group = "Harpoon" },
    { "<leader>b", group = "Buffer" },
    { "<leader>d", group = "Debugger" },
    { "<leader>c", group = "Comment" },
    { "<leader>v", group = "View" },
    { "<leader>t", group = "Tab/Terminal" },
    { "<leader>q", group = "Quickfix" },

    { "<leader>o", group = "OpenOther" },
    { "<leader>s", group = "Visuals" },
  })

  vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
  end, { desc = "Buffer Local Keymaps (which-key)" })
end)
