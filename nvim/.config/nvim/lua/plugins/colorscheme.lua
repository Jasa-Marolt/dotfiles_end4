return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      terminalColors = true,
      theme = "dragon", -- Set your preferred variant here
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd("colorscheme kanagawa") -- Use 'kanagawa' to trigger the variant in opts
    end,
  },
}
