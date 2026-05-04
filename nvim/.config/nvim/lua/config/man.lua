-- Add to ~/.config/nvim/init.lua
vim.keymap.set("n", "<leader>gm", function()
    local word = vim.fn.expand("<cword>")
    if word:match("^gl") then
        -- Uses xdg-open (Linux), open (macOS), or start (Windows)
        local cmd = "xdg-open https://registry.khronos.org/OpenGL-Refpages/gl4/html/" .. word .. ".xhtml"
        vim.fn.jobstart(cmd)
    else
        vim.cmd("Man " .. word)
    end
end, { desc = "Open man page for OpenGL function" })

vim.keymap.set("n", "<leader>gM", function()
    local word = vim.fn.expand("<cword>")
    if word:match("^gl") then
        require("telescope.builtin").man_pages({
            sections = { "ALL" },
            default_text = word,
        })
    end
end, { desc = "Open OpenGL man page" })
