return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- This triggers the plugin before saving
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      rust = { "rustfmt" }, -- Removed the lsp_format from here
      javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    -- Correct way to set global defaults
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
