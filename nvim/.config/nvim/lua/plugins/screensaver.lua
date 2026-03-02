return {
    "Root-lee/screensaver.nvim",
    config = function()
        --:ScreensaverStart
        require("screensaver").setup({
            -- ⏱️ Time in milliseconds before the screensaver starts
            idle_ms = 60 * 1000,

            -- 🚀 Automatically start screensaver after idle time (set to false for manual only)
            auto_start = true,

            -- 🛡️ Disable auto-start when Neovim loses focus (e.g. switching tmux windows)
            -- Requires `set -g focus-events on` in your tmux.conf
            disable_on_focus_lost = true,

            -- ⌨️ Key to exit the screensaver
            exit_key = "<Esc>",

            -- 🎬 List of enabled animations (defaults to all available)
            animations = {
                -- "matrix",
                "rain",
                "game_of_life",
                -- "move_left",
                -- "move_right",
                "scramble",
                "random_case",
                -- "bounce",
                -- "starfield",
                "pipes",
                -- "fire",
                -- "snow",
                -- "zoo",
            },

            -- 👻 Window transparency (0-100)
            winblend = 0,
        })
    end,
}
