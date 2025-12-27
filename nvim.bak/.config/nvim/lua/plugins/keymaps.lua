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
