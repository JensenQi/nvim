-- 底部终端插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/akinsho/toggleterm.nvim.git",
        version = "*",
        config = function()
            require("toggleterm").setup({
                open_mapping = "<esc>\\",
                size = 12,
                start_in_insert = true,
                close_on_exit = true,
                direction = "horizontal",
                autochdir = true
            })
        end
    }
}

