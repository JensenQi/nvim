return {
    {
        os.getenv("ghproxy") .. "https://github.com/lukas-reineke/indent-blankline.nvim.git",
        version = "*",
        main = "ibl",
        config = function()
            require("ibl").setup({
                scope = {
                    show_start = false
                }
            })
        end
    }
}