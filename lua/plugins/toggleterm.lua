-- 底部终端插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/akinsho/toggleterm.nvim.git",
        version = "*",
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<c-\>]],
                start_in_insert = true,
                direction = "horizontal",
                autochdir = true
            })
        end
    }
}
