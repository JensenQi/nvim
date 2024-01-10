-- 折叠美化插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/anuvyklack/pretty-fold.nvim.git",
        version = "*",
        config = function()
            require('pretty-fold').setup({})
        end
    }
}
