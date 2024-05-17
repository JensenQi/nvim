-- 待办高亮插件
local keymap = require("keymap")
keymap.map2cmd("n", keymap.open_todo, "<CMD>TodoTelescope initial_mode=normal<CR>")

return {
    {
        os.getenv("ghproxy") .. "https://github.com/folke/todo-comments.nvim.git",
        version = "*",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/nvim-telescope/telescope.nvim.git",
            os.getenv("ghproxy") .. "https://github.com/nvim-lua/plenary.nvim.git"
        },
        config = function()
            require("todo-comments").setup({
            })
        end
    }
}

