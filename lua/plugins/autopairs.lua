-- 自动补全括号插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/windwp/nvim-autopairs.git",
        version = "*",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                enable_afterquote = false, -- 避免 foo("bar" -> foo("bar")
                map_cr = false             -- 禁用 CR, 避免与自动补全的 CR 冲突
            })
        end
    }
}
