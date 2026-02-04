return {
    "azabiong/vim-highlighter",
    init = function()
        -- Custom keybindings (change these to your preference)
        vim.g.HiSet = "f<CR>" -- Highlight word/selection
        vim.g.HiErase = "f<BS>" -- Remove highlight
        vim.g.HiClear = "f<C-L>" -- Clear all highlights
        vim.g.HiFind = "f<Tab>" -- Find next highlighted word
        vim.g.HiSetSL = "t<CR>" -- Save highlights
        --f+del /delete highlight /one time highlight
        --f+enter /set highlight / if in one time highlight mode it changes to follow highlight/f+del turns it off
        vim.keymap.set("n", "gl", "<Cmd>Hi><Cr>", { desc = "Go to next highlight" })
        vim.keymap.set("n", "gh", "<Cmd>Hi<<Cr>", { desc = "Go to prev highlight" })

        vim.keymap.set("n", "gj", "<Cmd>Hi<<Cr>", { desc = "Go to prev highlight" })
        vim.keymap.set("n", "gk", "<Cmd>Hi<<Cr>", { desc = "Go to prev highlight" })
    end,
}
