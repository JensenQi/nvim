return {
    {
        os.getenv("ghproxy") .. "https://github.com/numToStr/Comment.nvim.git",
        version = "*",
        lazy = false,
        config = function()
            require('Comment').setup({
                mappings = {
                    basic = false,
                    extra = false,
                }
            })
        end
    }
}
