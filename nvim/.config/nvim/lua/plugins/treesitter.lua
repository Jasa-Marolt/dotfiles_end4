return   {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        -- Add languages you want installed
        ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "html", "python" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
