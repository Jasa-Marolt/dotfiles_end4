return {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    config = function()
        require("jupytext").setup({
            style = "markdown",
            output_extension = "md",
            force_ft = "markdown",
            jupytext_command = vim.fn.expand("~/.virtualenvs/neovim/bin/jupytext"),
        })
    end,
}
