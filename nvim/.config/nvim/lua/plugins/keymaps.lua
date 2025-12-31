-- Outside (Normal Mode): Open or Focus
vim.keymap.set("n", "<C-.>", function()
    local term = Snacks.terminal.get(nil, { cwd = vim.fn.getcwd() })
    if term and term.win and vim.api.nvim_win_is_valid(term.win) then
        vim.api.nvim_set_current_win(term.win)
    elseif term then
        term:toggle()
    end
end, { desc = "Open/Focus Terminal" })

-- Hide/Toggle off
vim.keymap.set("t", "<C-.>", function()
    Snacks.terminal.toggle()
end, { desc = "Terminal: Hide" })

-- Move back to previous window (main buffer)
vim.keymap.set("t", "<C-,>", [[<C-\><C-n><C-w>p]], { desc = "Go to previous window" })

-- Show terminal keybinds help
vim.keymap.set("t", "?", function()
    local help_text = [[
Terminal Mode Keybinds:
  <C-.>       - Hide/close terminal
  <C-,>       - Go to previous window
  <C-h/j/k/l> - Navigate to window (left/down/up/right)
  <C-Up>      - Increase terminal height
  <C-Down>    - Decrease terminal height
  ?           - Show this help
]]
    vim.notify(help_text, vim.log.levels.INFO)
end, { desc = "Show terminal keybinds help" })

local function run_build_cmd()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
        local cmd = line:match("BUILD:%s*(.*)")
        if cmd then
            local term = Snacks.terminal.get(nil, { cwd = vim.fn.getcwd() })
            if term then
                -- Open/show the terminal if it's not visible
                if not term.win or not vim.api.nvim_win_is_valid(term.win) then
                    term:toggle()
                end
                -- Get the terminal channel from the buffer
                local chan = vim.bo[term.buf].channel
                if chan then
                    vim.fn.chansend(chan, cmd .. "\n")
                end
            end
            return
        end
    end
    vim.notify("No BUILD: found in file", vim.log.levels.WARN)
end

-- Set the keybinding (e.g., <leader>rb for "Run Build")
vim.keymap.set("n", "<leader>rb", run_build_cmd, { desc = "Run BUILD: from file" })

-- Normal Mode mappings
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })

-- Terminal Mode mappings (while inside the terminal)
vim.keymap.set("t", "<C-Up>", [[<C-\><C-n>:resize +2<CR>i]], { desc = "Increase terminal height" })
vim.keymap.set("t", "<C-Down>", [[<C-\><C-n>:resize -2<CR>i]], { desc = "Decrease terminal height" })

-- Navigate back to previous buffer with Ctrl+hjkl
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Go to left window" })
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Go to below window" })
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Go to above window" })
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Go to right window" })

--DIAGNOSTICS
-- Show line diagnostics on <leader>d
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
--execute code action
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
-- Jump to next/previous error
vim.keymap.set("n", "[d", vim.diagnostic.get_next, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.get_prev, { desc = "Go to next diagnostic" })

-- Open diagnostic list (Quickfix)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, { desc = "Open diagnostic list" })

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
