-- 启动耗时插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/dstein64/vim-startuptime.git",
        version = "*"
    }
}
