-- 缩进块提示插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/lukas-reineke/indent-blankline.nvim.git",
        version = "*",
        main = "ibl",
        config = function()
            require("ibl").setup({
                indent = {
                    char = '│',
                    smart_indent_cap = true,
                },
                scope = {
                    enabled = true,
                    show_start = false,
                    show_end = false
                }
            })
        end
    }
}
