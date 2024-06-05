-- 缩进块提示插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/lukas-reineke/indent-blankline.nvim.git",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/VidocqH/auto-indent.nvim.git",
            os.getenv("ghproxy") .. "https://github.com/nvim-treesitter/nvim-treesitter.git",
        },
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
            require("auto-indent").setup({
                -- 根据语法自动调整 tab 按键的缩进空格数量
                indentexpr = function(lnum)
                    return require("nvim-treesitter.indent").get_indent(lnum)
                end
            })
        end
    }
}
