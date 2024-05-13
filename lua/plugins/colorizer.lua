-- RGB 字符串颜色高亮
return {
    {
        os.getenv("ghproxy") .. "https://github.com/norcalli/nvim-colorizer.lua.git",
        version = "*",
        config = function()
            require("colorizer").setup()
        end
    }
}

