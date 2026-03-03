return {
    "max397574/better-escape.nvim",
    config = function()
        require("better_escape").setup({
            timeout = 70, -- after `timeout` passes, you can press the escape key and the plugin will ignore it
            default_mappings = true, -- setting this to false removes all the default mappings
            mappings = {
                -- i for insert
                i = {
                    j = {
                        -- These can all also be functions
                        k = "<Esc>",
                    },
                    k = {
                        j = "<Esc>",
                    },
                },
            },
        })
    end,
}
