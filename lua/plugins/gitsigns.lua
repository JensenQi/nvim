-- git blame 插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/lewis6991/gitsigns.nvim.git",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/FabijanZulj/blame.nvim.git"
        },
        config = function()
            require("blame").setup({ date_format = "%Y/%m/%d" })
            require('gitsigns').setup({
                numhl = true,
                current_line_blame = true,
                current_line_blame_opts = { virt_text = false, delay = 50 },
                -- current_line_blame_formatter = '<abbrev_sha> 📢<summary> 🧑<committer> 📅<author_time:%Y-%m-%d>',
                current_line_blame_formatter = '<summary>',
            })
        end
    }
}

