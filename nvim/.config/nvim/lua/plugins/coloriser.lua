-- colors hex colors in their responding color
-- #FFF
-- https://github.com/norcalli/nvim-colorizer.lua
return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup()
    end,
}
