--
local keymap = require("keymap")
local util = require("util")

return {
    {
        os.getenv("ghproxy") .. "https://github.com/Wansmer/treesj.git",
        version = "*",
        dependencies = {
            os.getenv("ghproxy") .. 'https://github.com/nvim-treesitter/nvim-treesitter'
        },
        config = function()
            require('treesj').setup({
                use_default_keymaps = false,
            })
            keymap.map2cmd('n', keymap.tree_join, "<CMD>TSJToggle<CR>")
        end,

    }
}
