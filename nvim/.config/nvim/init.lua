-- nvim --headless -c 'messages' -c 'qall'
-- :lua print(require("autocmds"))
-- :checkhealth
-- :messages
-- :checkhealth vim.lsp
-- :verbose nmap [keybind]
require("options")
require("autocmds")
require(
  "keymaps"
)
