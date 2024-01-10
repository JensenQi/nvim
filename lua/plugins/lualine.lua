-- 底部状态栏插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/nvim-lualine/lualine.nvim.git",
        version = "*",
        config = function()
            require('lualine').setup()
        end
    }
}
