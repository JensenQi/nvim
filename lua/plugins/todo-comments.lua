-- 待办高亮插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/folke/todo-comments.nvim.git",
        version = "*",
        dependencies = { os.getenv("ghproxy") .. "https://github.com/nvim-lua/plenary.nvim.git" },
        config = function()
            require("todo-comments").setup({
            })
        end
    }
}
