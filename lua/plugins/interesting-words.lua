return {
    {
        os.getenv("ghproxy") .. "https://github.com/Mr-LLLLL/interestingwords.nvim.git",
        version = "*",
        config = function()
            require('interestingwords').setup({
                colors = { '#aeee00', '#ff0000', '#0000ff', '#b88823', '#ffa724', '#ff2c4b' },
                search_count = true,
                navigation = true,
                search_key = "<leader>f",
                cancel_search_key = "<leader>F",
                --  color_key = "<leader>k",
                --  cancel_color_key = "<leader>K",
            })
        end
    }
}
