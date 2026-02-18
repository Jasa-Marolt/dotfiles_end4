--test
-- load the session for the current directory
vim.keymap.set("n", "<leader>qs", function()
    require("persistence").load()
end, { desc = "Load sesson for current dir" })

-- select a session to load
vim.keymap.set("n", "<leader>qS", function()
    require("persistence").select()
end, { desc = "Select session" })

-- load the last session
vim.keymap.set("n", "<leader>ql", function()
    require("persistence").load({ last = true })
end, { desc = "Load last session" })

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function()
    require("persistence").stop()
end, { desc = "Stop persistence" })
vim.keymap.set("n", "č", function()
    local buf = vim.api.nvim_get_current_buf()
    local row = vim.api.nvim_win_get_cursor(0)[1] - 1

    -- Define the highlight namespace
    local ns = vim.api.nvim_create_namespace("line_highlighter")
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

    -- Apply highlight to the current line range
    vim.api.nvim_buf_add_highlight(buf, ns, "Visual", row, 0, -1)
end, { desc = "Highlight line using TS namespace" })

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
local function delete_small_parentheses()
    Snacks.notify("removed function param")
    local line = vim.api.nvim_get_current_line()
    local _, col = unpack(vim.api.nvim_win_get_cursor(0))
    col = col + 1 -- Lua strings are 1-indexed

    -- Find the nearest '(' to the left
    local left_pos = nil
    for i = col, 1, -1 do
        if line:sub(i, i) == "(" or line:sub(i, i) == "," then
            left_pos = i
            break
        end
    end

    -- Find the nearest ')' to the right
    local right_pos = nil
    for i = col, #line do
        if line:sub(i, i) == ")" or line:sub(i, i) == "," then
            right_pos = i
            break
        end
    end

    -- Validate positions and check distance
    if left_pos and right_pos then
        local diff = right_pos - left_pos - 1

        if diff > 0 and diff <= 40 then
            local new_line = line:sub(1, left_pos) .. line:sub(right_pos)
            vim.api.nvim_set_current_line(new_line)

            vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], left_pos - 1 })
        else
            print("Gap too large (" .. diff .. ") or empty")
        end
    else
        print("Parentheses not found")
    end
end
vim.keymap.set("n", "di,", delete_small_parentheses, {
    desc = "delete function parameter",
})

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
vim.keymap.set("v", "p", [["_dP]], { desc = "Paste (discard overwritten text)" })
vim.keymap.set("v", "P", [["_dP]], { desc = "Paste (discard overwritten text)" })

local map = vim.keymap.set
map("n", "q:", "<nop>")
map("n", "qq", "<nop>")
vim.keymap.set({ "n" }, "<C-s>", function()
    vim.cmd("w")
end, { desc = "Save file" })

-- Move between windows using Control + hjkl
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
-- map("i", "<C-h>", "<Left>", { desc = "Move left" })
-- map("i", "<C-j>", "<Down>", { desc = "Move down" })
-- map("i", "<C-k>", "<Up>", { desc = "Move up" })
-- map("i", "<C-l>", "<Right>", { desc = "Move right" })

-- Center cursor after certain movements
map("n", "n", "nzz", { desc = "Next search result (centered)" })
map("n", "N", "Nzz", { desc = "Previous search result (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })

return {}
