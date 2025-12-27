return {
  -- Add Kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- Load this during startup
    priority = 1000, -- Load this before other plugins
    opts = {
      -- Optional: Add your configuration here
      transparent = false,
      terminalColors = true,
      theme = "wave", -- Options: "wave", "dragon", "lotus"
    },
  },

  -- Configure LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
