vim.keymap.set("n", "<c-.>", function()
  Snacks.terminal.toggle(nil, { cwd = vim.fn.getcwd() })
end, { desc = "Toggle terminal (Root Dir)" })

vim.keymap.set("t", "<c-.>", function()
  Snacks.terminal.toggle()
end, { desc = "Hide terminal" })
return {
  -- This is a 'plugin' spec, but we use it to add keymaps
  {
    "LazyVim/LazyVim", -- Use an existing plugin to attach your maps
    keys = {
      -- Visual Mode Paste Remap
      { "p", [["_dP]], mode = "v", desc = "Paste (discard overwritten text)" },
      { "P", [["_dP]], mode = "v", desc = "Paste (discard overwritten text)" },
    },
  },
}
